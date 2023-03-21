
import 'package:bandit/game/components/actors/base_actor.dart';
import 'package:bandit/game/components/dasher/can_dash_mixin.dart';
import 'package:bandit/game/util/game_layers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DashRange extends PositionComponent with CollisionCallbacks {
  
  final double maxSize;
  
  late double radius = maxSize / 2;

  bool get reloaded => _timeTillReloaded <= 0;
  double _timeTillReloaded = 0;

  // The time it takes fo tis to reload
  final double reloadTime;
  final Function(BaseActor other)? onDetect;

  DashRange({this.onDetect, this.maxSize = 1000, this.reloadTime = 0.6}) : super(
    priority: GameLayers.lines.layer,
    position: Vector2.all(-1 * maxSize / 2 + 25),
    size: Vector2.all(maxSize)
  );
    
  @override
  Future<void>? onLoad() async {

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
    canvas.drawDashedCircle(Vector2.all(radius).toOffset(), radius, _rangePaint, rotation: (reloadTime - _timeTillReloaded) / reloadTime);
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