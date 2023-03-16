
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

mixin CanDash on Component {

  bool _dashing = false;
  double _dashSpeed = 0.2;
  void setDashing(bool dashing) => _dashing = dashing;
  void setDashSpeed(double speed) => _dashSpeed = speed;

  void dashTo(Vector2 position){
    setDashing(true);
    final effect = MoveToEffect(
      position, 
      EffectController(
        duration: _dashSpeed, 
        curve: Curves.decelerate
      ),
      onComplete: () => setDashing(false),
    );
    add(effect);
  }
}