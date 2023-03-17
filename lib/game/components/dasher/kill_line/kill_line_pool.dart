
import 'package:bandit/game/components/actors/base_actor.dart';
import 'package:bandit/game/components/dasher/can_dash_mixin.dart';
import 'package:bandit/game/components/dasher/kill_line/kill_line.dart';
import 'package:flame/components.dart';

class KillLinePool extends PositionComponent {

  static const Duration defaultLineLife = Duration(milliseconds: 300);

  final Duration lineLife;

  KillLine? line;

  KillLinePool({this.lineLife = KillLinePool.defaultLineLife});

  void startLine(Vector2 start){
    removeLine();
    line = KillLine(start: start);
    line!.traceTo(start);
    add(line!);
  }

  void traceLine(Vector2 end){
    if(line == null) return;
    line!.traceTo(end);
  }

  void endLine(){
    if(line == null) return;
    line!.stop();
    
    // start a timer for the line life and then remove the line
    Future.delayed(lineLife, removeLine);
  }

  void removeLine(){
    if(line == null) return;
    line!.clear();
    remove(line!);
    line = null;
  }

  bool get hasActiveLine => line != null && line!.drawing;

  // bool get isPlayerPool => actor.type == BaseActorType.player;
  
  // CanDashActor get actor {
  //   assert(parent is CanDashActor, 'KillLinePool must be added to a CanDashActor');
  //   return parent as CanDashActor;
  // }
}