
import 'package:bandit/game/components/actors/base_actor.dart';
import 'package:bandit/game/components/dasher/can_dash_mixin.dart';
import 'package:bandit/game/util/game_layers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DashRange extends PositionComponent with CollisionCallbacks {
  
  final double initialSize;
  
  bool get reloaded => _timeTillReloaded <= 0;
  double _timeTillReloaded = 0;

  // The time it takes fo tis to reload
  final double reloadTime;
  final Function(BaseActor other)? onDetect;

  DashRange({this.onDetect, this.initialSize = 1000, this.reloadTime = 0.6}) : super(
    priority: GameLayers.lines.layer,
    size: Vector2.all(initialSize)
  );
    
  @override
  Future<void>? onLoad() async {
    // debugMode = true;

    updatePosition();

    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if(!reloaded || other is! BaseActor || actor.dashing || (other is CanDashActor && other.dashing)) return;

    final otherActor = other as BaseActor;
    onDetect?.call(otherActor);
  }

  @override
  void update(double dt) {
    if(!reloaded){
      _timeTillReloaded = math.max(_timeTillReloaded - dt, 0);
    }
  }

  @override
  void render(Canvas canvas) {
    // debugMode = true; // Enables debug mode for the player
    // debugPaint.strokeWidth = 5; // Sets the width of the debug lines
    // canvas.drawCircle(parentToLocal(center).toOffset(), 2, _rangePaint);
    canvas.drawDashedCircle(parentToLocal(center).toOffset(), radius, _rangePaint, rotation: (reloadTime - _timeTillReloaded) / reloadTime);
  }

  CanDashActor get actor {
    assert(parent is CanDashActor, 'DashRange must be added to a CanDashActor');
    return parent as CanDashActor;
  }

  Paint get _rangePaint => Paint()
    ..color = (actor.isEnemy ? Colors.red : Colors.blue).withOpacity(reloaded ? 1.0 : 0.4)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;

  Vector2 bindToRange(Vector2 position) {
    Vector2 normalized = position - actor.center;
    if(normalized.distanceTo(Vector2.zero()) > radius){
      // Reduce the magnitude of the vector to the radius
      normalized = normalized.normalized() * radius;
      return actor.center + normalized;
    }

    return position;
  }

  void reload() {
    _timeTillReloaded = reloadTime;
  }

  double get radius => size.x / 2;

  void shrink(double amount){
    final newSize = math.max((radius * 2) - amount, actor.size.x);
    size = Vector2.all(newSize);
    updatePosition();
  }

  void grow(double amount){
    final newSize = math.min((radius * 2) + amount, initialSize);
    size = Vector2.all(newSize);
    updatePosition();
  }

  void updatePosition(){
    position = Vector2.all(-1 * size.x / 2 + actor.size.x / 2);
  }
}

extension on Canvas {
  void drawDashedCircle(Offset center, double radius, Paint dashPaint, {double dashWidth = 10, double dashSpace = 5, double rotation = 1.0}) {
    final circleCircumference = 2 * math.pi * radius;
    final dashCount = (circleCircumference / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < rotation * dashCount; i++) {
      final startAngle = i * (dashWidth + dashSpace) / radius;
      final endAngle = (i * (dashWidth + dashSpace) + dashWidth) / radius;
      final startPoint = Offset(
        center.dx + radius * math.cos(startAngle),
        center.dy + radius * math.sin(startAngle),
      );
      final endPoint = Offset(
        center.dx + radius * math.cos(endAngle),
        center.dy + radius * math.sin(endAngle),
      );
      drawLine(startPoint, endPoint, dashPaint);
    }
  }

}