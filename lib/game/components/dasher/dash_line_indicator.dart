

import 'package:bandit/game/components/actors/base_actor.dart';
import 'package:bandit/game/components/dasher/can_dash_mixin.dart';
import 'package:bandit/game/util/game_layers.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class DashLineIndicator extends Component {
  
  late Vector2 _endPoint = actor.center;

  DashLineIndicator() : super(
    priority: GameLayers.indicators.layer
  );

  @override
  void render(Canvas canvas) {
    
    if(isClear || actor.type != BaseActorType.player) return; // Don't render if there is no line to draw

    final start = actor.parentToLocal(actor.center).toOffset();
    final end = actor.parentToLocal(_endPoint).toOffset();
    canvas.drawLine(start, end, _paint);
  }

  CanDashActor get actor {
    assert(parent is CanDashActor, 'DashLineIndicator must be added to a CanDashActor');
    return parent as CanDashActor;
  }

  Paint get _paint => Paint()
    ..color = Colors.amber.withOpacity(0.2)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  bool get isClear => _endPoint == actor.center;

  Vector2 get end => _endPoint;

  void clear() {
    _endPoint = actor.center;
  }
  void setPoint(Vector2 point) {
    _endPoint = point;
  }
}