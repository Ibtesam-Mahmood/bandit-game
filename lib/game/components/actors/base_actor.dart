
import 'package:flame/components.dart';

enum BaseActorType { player, enemy }

mixin BaseActor on PositionComponent {

  late int health = baseHealth;
  int get baseHealth => 1;
  bool get isDead => health <= 0;
  void heal() => health += 1;
  void damage() => health -= 1;
  
  BaseActorType get type;
  bool get isPlayer => type == BaseActorType.player;
  bool get isEnemy => type == BaseActorType.enemy;

  @override
  void update(double dt) {
    super.update(dt);
    if(isDead) onDeath();
  }

  void onDeath(){}
}