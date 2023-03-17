
import 'package:bandit/game/bandit_game.dart';
import 'package:bandit/game/components/actors/base_actor.dart';
import 'package:bandit/game/components/actors/enemy/enemy.dart';
import 'package:bandit/game/components/dasher/can_dash_mixin.dart';
import 'package:bandit/game/components/mixins/face_movement_mixin.dart';
import 'package:bandit/game/util/game_layers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class BanditPlayer extends SpriteAnimationComponent with BaseActor, CollisionCallbacks, HasGameRef<BanditGame>, CanDashActor, FaceMovementDirection {

  static final Vector2 playerSize = Vector2(50, 50);
  static final Vector2 playerStart = Vector2(300, 300);

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
  BaseActorType get type => BaseActorType.player;

  @override
  Future<void> onLoad() async {
    debugMode = true; // Enables debug mode for the player
    debugPaint.strokeWidth = 5; // Sets the width of the debug lines

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
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
        
    if(dashing) return; // If the player is invincible, return
    
    if(other is Enemy){
      gameRef.gameover(); // Calls the gameover function in the game
    }
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

  @override
  void setDashing(bool dashing){
    super.setDashing(dashing);
    // Based on the value sets the opacity fo the sprite
    setAlpha(dashing ? 127 : 255);
  }

}