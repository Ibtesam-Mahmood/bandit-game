import 'package:bandit/game/components/actors/enemy/enemy_spawner.dart';
import 'package:bandit/game/components/actors/player/player.dart';
import 'package:bandit/menu/GameOverMenu.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';

import '../blocs/score/score_bloc.dart';

class BanditGame extends FlameGame with TapDetector, PanDetector, HasCollisionDetection {

  final ScoreBloc scoreBloc;
  late BanditPlayer player = BanditPlayer();
  late EnemySpawer enemySpawner = EnemySpawer();
  late ScreenHitbox screen = ScreenHitbox();
  int score = 0;

  BanditGame({required this.scoreBloc});
  
  @override
  Future<void>? onLoad() async {

    add(screen); // Adds a hitbox around the screen
    add(player); // Adds the player
    add(enemySpawner); // Adds the spawner

    // Start the spawner
    enemySpawner.startSpawner();
    overlays.add('DashboardOverlay');

    startBgmMusic();

    return super.onLoad();
  }

   void startBgmMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('Menu.mp3');
  }

  void stopBgmMusic(){
    FlameAudio.bgm.stop();
  }

  void dashMusic(){
    FlameAudio.play('Dash.mp3');
  }

  void deathMusic(){
    FlameAudio.play('death.mp3');
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    super.onPanUpdate(info);

    player.prepareDash(info.eventPosition.global);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    super.onPanEnd(info);
    player.dash();
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    dashMusic();
    player.prepareDash(info.eventPosition.global);

  }

  @override
  void onTapCancel() {
    super.onTapCancel();

    player.stopDash();
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);

    player.dash();
  }

  void gameover(){
    enemySpawner.stopSpawner(); // Stops the spawner
    pauseEngine(); // Pauses the game
    deathMusic();
    overlays.add(GameOverMenu.id);
  }

  void addToScore([int amount = 1]){
    score += amount;
    scoreBloc.add(IncreaseScoreEvent());
  }

  // Resets the game to inital state. Should be called
  // while restarting and exiting the game.
  void reset() {
    // First reset player, enemy manager and power-up manager .
    remove(player);
    remove(enemySpawner);
    enemySpawner = EnemySpawer();
    player = BanditPlayer();
    add(enemySpawner);
    add(player);

    enemySpawner.startSpawner();

    resumeEngine();
    
  }
}