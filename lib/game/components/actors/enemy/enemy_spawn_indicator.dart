
import 'dart:async';

import 'package:bandit/game/components/actors/enemy/enemy.dart';
import 'package:bandit/game/util/game_layers.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class EnemySpawnIndicator extends PositionComponent implements OpacityProvider {

  static const double defaultDuration = 1; //In seconds

  final double delay;
  final Completer<void> completer = Completer();

  final Paint _paint = Paint()
    ..color = Colors.amber.withOpacity(0)
    ..style = PaintingStyle.fill
    ..strokeWidth = 3;

  EnemySpawnIndicator({required Enemy enemy, this.delay = EnemySpawnIndicator.defaultDuration}) : super(
    position: enemy.position,
    size: enemy.size,
    priority: GameLayers.indicators.layer
  );

  @override
  FutureOr<void> onLoad() {
    return super.onLoad();
  }


  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(parentToLocal(center).toOffset(), size.x / 2 , _paint);
  }

  void fade(){
    final fadeOut = OpacityEffect.to(
      1.0,
      EffectController(
        duration: delay,
        curve: Curves.decelerate,
      ),
      target: this,
      onComplete: () {
        completer.complete();
      },
    );
    add(fadeOut);
  }

  @override
  double get opacity => _paint.color.opacity;
  @override
  set opacity(double value) => _paint.color = _paint.color.withOpacity(value);
}