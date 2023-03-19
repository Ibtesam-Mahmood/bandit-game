
import 'dart:math' as math;

import 'package:bandit/game/components/actors/base_actor.dart';
import 'package:bandit/game/components/dasher/kill_line/kill_line_pool.dart';
import 'package:bandit/game/util/game_layers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class KillLine extends RectangleComponent with CollisionCallbacks {

  final Vector2 start;
  Vector2? end;
  bool drawing = false;

  KillLine({
    required Vector2 start, 
  }) :start = start.clone(), 
      super(
        position: start.clone(), 
        anchor: Anchor.topRight, 
        size: Vector2.zero(), 
        priority: GameLayers.lines.layer
      );

  @override
  Future<void>? onLoad() async {
    // debugMode = true;

    position = pool.actor.parentToLocal(start);
    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    
    final width = size.x;
    if(width <= 0 || parent == null) return; 

    canvas.drawLine(Vector2(0, 0).toOffset(), Vector2(width, 0).toOffset(), _paint);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    // dammage the other actor
    if(other is BaseActor && other.type != pool.actor.type){
      other.damage();
    }
  }

  Paint get _paint => Paint()
    ..color = (pool.actorType == BaseActorType.player ? Colors.white : Colors.red).withOpacity(0.5)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  KillLinePool get pool {
    assert(parent is KillLinePool, 'KillLine must be added to a KillLinePool');
    return parent as KillLinePool;
  }

  void clear(){
    size = Vector2.zero();
    angle = 0;
    // end = null;
  }

  void traceTo(Vector2 newEnd) {
    drawing = true;
    // end = newEnd;
    // Calculate the angle and magnitude of the line
    final diff = (newEnd - start).clone();
    bool isUpwards = diff.y < 0;
    angle = (isUpwards ? -1 : 1) * Vector2(1, 0).angleTo(diff);
    size = Vector2(diff.length, _paint.strokeWidth);
  }

  void stop() {
    drawing = false;
  }
}