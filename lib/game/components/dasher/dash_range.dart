
import 'package:bandit/game/components/dasher/can_dash_mixin.dart';
import 'package:bandit/game/util/game_layers.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DashRange extends Component {
  
  final double maxSize;
  
  late double radius = maxSize / 2;

  DashRange({this.maxSize = 500}) : super(
    priority: GameLayers.lines.layer
  );

  @override
  void render(Canvas canvas) {
    debugMode = true; // Enables debug mode for the player
    debugPaint.strokeWidth = 5; // Sets the width of the debug lines
    canvas.drawDashedCircle(actor.parentToLocal(actor.center).toOffset(), radius, _rangePaint);
  }

  CanDashActor get actor {
    assert(parent is CanDashActor, 'Dasher must be added to a CanDashActor');
    return parent as CanDashActor;
  }

  Paint get _rangePaint => Paint()
    ..color = (actor.isEnemy ? Colors.red : Colors.blue).withOpacity(0.4)
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
}

extension on Canvas {
  void drawDashedCircle(Offset center, double radius, Paint dashPaint, {double dashWidth = 10, double dashSpace = 5}) {
    final circleCircumference = 2 * math.pi * radius;
    final dashCount = (circleCircumference / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < dashCount; i++) {
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