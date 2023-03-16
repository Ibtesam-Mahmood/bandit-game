
import 'package:flame/components.dart';

enum BaseActorType { player, enemy }

mixin BaseActor on PositionComponent {
  BaseActorType get type;
  
  bool get isPlayer => type == BaseActorType.player;
  bool get isEnemy => type == BaseActorType.enemy;
}