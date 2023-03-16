
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

mixin FaceMovementDirection on PositionComponent {

  Vector2 _lastPosition = Vector2(0, 0);

  @override
  void update(double dt) {
    super.update(dt);
    turnToDirectionPosition();
  }

  void turnToDirectionPosition(){
    // flips the sptrite based on the position of the player
    if((isFlippedHorizontally && x > _lastPosition.x) || (!isFlippedHorizontally && x < _lastPosition.x)){
      flipHorizontally();
    }
    _lastPosition = position;
  }
}