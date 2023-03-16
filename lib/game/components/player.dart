
import 'package:bandit/game/bandit_game.dart';
import 'package:bandit/game/util/game_layers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class BanditPlayer extends SpriteAnimationComponent with CollisionCallbacks, HasGameRef<BanditGame> {

  static final Vector2 playerSize = Vector2(100, 100);
  static final Vector2 playerStart = Vector2(100, 100);

  double _speed = 0.2;

  BanditPlayer() : super(
    size: BanditPlayer.playerSize,
    position: BanditPlayer.playerStart,
    priority: GameLayers.player.layer,
  );

/*
 
      ___                      _     _           
     / _ \__   _____ _ __ _ __(_) __| | ___  ___ 
    | | | \ \ / / _ \ '__| '__| |/ _` |/ _ \/ __|
    | |_| |\ V /  __/ |  | |  | | (_| |  __/\__ \
     \___/  \_/ \___|_|  |_|  |_|\__,_|\___||___/
                                                 
 
*/

  @override
  Future<void> onLoad() async {
    // debugMode = true; // Enables debug mode for the player
    // debugPaint.strokeWidth = 5; // Sets the width of the debug lines

    add(CircleHitbox()); // Adds a hitbox to the player in the shape of a circle

    // Loads in the image from the assets folder
    final image = await Flame.images.load('ember.png');

    // Sets the animation to be a sequence of 4 images, each 0.1 seconds long, and each 16x16 pixels
    animation = SpriteAnimation.fromFrameData(
      image, 
      SpriteAnimationData.sequenced(
        amount: 4, 
        stepTime: 0.1, 
        textureSize: Vector2(16, 16)
      )
    );

    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    gameRef.gameover(); // Calls the gameover function in the game
  }

  @override
  void update(double dt) {
    super.update(dt);


  }

/*
 
     ___       _             __                
    |_ _|_ __ | |_ ___ _ __ / _| __ _  ___ ___ 
     | || '_ \| __/ _ \ '__| |_ / _` |/ __/ _ \
     | || | | | ||  __/ |  |  _| (_| | (_|  __/
    |___|_| |_|\__\___|_|  |_|  \__,_|\___\___|
                                               
 
*/

  void moveTo(Vector2 position){
    final effect = MoveToEffect(position, EffectController(duration: _speed, curve: Curves.decelerate));
    add(effect);
  }

}