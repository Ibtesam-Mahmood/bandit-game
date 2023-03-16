
import 'package:bandit/game/components/actors/base_actor.dart';
import 'package:bandit/game/components/dasher/dash_line_indicator.dart';
import 'package:bandit/game/components/dasher/dash_range.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

mixin CanDashActor on BaseActor {

  late final DashRange range = DashRange();
  late final DashLineIndicator _rangeIndicator = DashLineIndicator();

  bool dashing = false;
  double dashSpeed = 0.2;
  void setDashing(bool dashing) => this.dashing = dashing;
  void setDashSpeed(double speed) => dashSpeed = speed;
  
  @override
  Future<void>? onLoad() async {

    add(range);
    add(_rangeIndicator);

    return super.onLoad();
  }

  void stopDash() {
    if(dashing) return;
    _rangeIndicator.clear();
  }

  void prepareDash(Vector2 position) {
    if(dashing) return;
    
    // Bind the position to the dash range
    position = range.bindToRange(position);

    // set the indicator to the position
    _rangeIndicator.setPoint(position);
  }

  void dash([Vector2? position]){
    if(dashing || _rangeIndicator.isClear) return;
    setDashing(true);
    final effect = MoveToEffect(
      (position ?? _rangeIndicator.end) - Vector2.all(width/2), 
      EffectController(
        duration: dashSpeed, 
        curve: Curves.decelerate
      ),
      onComplete: () => setDashing(false),
    );
    add(effect);
  }
}