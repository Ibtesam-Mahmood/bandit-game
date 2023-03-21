
import 'package:bandit/game/bandit_game.dart';
import 'package:bandit/game/components/actors/base_actor.dart';
import 'package:bandit/game/components/dasher/dash_line_indicator.dart';
import 'package:bandit/game/components/dasher/dash_range.dart';
import 'package:bandit/game/components/dasher/kill_line/kill_line_pool.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

mixin CanDashActor on BaseActor {

  double get initialDashRange => 1000;
  double get dashReloadTime => 0.3;
  Duration get lineLife => KillLinePool.defaultLineLife;

  late final DashRange range = DashRange(
    maxSize: initialDashRange,
    reloadTime: dashReloadTime,
    onDetect: onDetect
  );
  late final DashLineIndicator _rangeIndicator = DashLineIndicator();
  late final KillLinePool killLinePool = KillLinePool(
    actor: this,
    lineLife: lineLife
  );

  bool dashing = false;
  double dashSpeed = 800;
  void setDashing(bool dashing) => this.dashing = dashing;
  void setDashSpeed(double speed) => dashSpeed = speed;
  
  @override
  Future<void>? onLoad() async {

    add(range);
    add(_rangeIndicator);
    parent?.add(killLinePool);

    return super.onLoad();
  }

  
  @override
  void onDeath() {
    super.onDeath();
    killLinePool.clear();
    parent?.remove(killLinePool);
  }

  @override
  void damage([bool override = false]) {
    if(!dashing || override) super.damage(override);
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // If the killLinePool has an active line than update it with the current center
    if(killLinePool.hasActiveLine){
      killLinePool.traceLine(center);
    }
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
    if(dashing || _rangeIndicator.isClear) {
      return;
    } else if(!range.reloaded) {
      return _rangeIndicator.clear();
    }

    range.reload();
    setDashing(true);
    killLinePool.startLine(center);
    final effect = MoveToEffect(
      (position ?? _rangeIndicator.end) - Vector2.all(width/2), 
      EffectController(
        speed: dashSpeed, 
        curve: Curves.decelerate
      ),
      onComplete: () {
        setDashing(false);
        killLinePool.endLine();
      },
    );
    add(effect);
  }

  void onDetect(BaseActor other){}

}