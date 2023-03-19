
import 'package:bandit/game/components/actors/base_actor.dart';
import 'package:bandit/game/components/dasher/can_dash_mixin.dart';
import 'package:bandit/game/components/dasher/kill_line/kill_line.dart';
import 'package:flame/components.dart';

class KillLinePool extends Component {

  static const Duration defaultLineLife = Duration(milliseconds: 200);

  final Duration lineLife;

  KillLine? line;
  CanDashActor actor;

  KillLinePool({
    required this.actor,
    this.lineLife = KillLinePool.defaultLineLife
  }) : super(
    // position: Vector2.zero(),
  );
  

  void startLine(Vector2 start){
    removeLine();
    line = KillLine(start: start);
    add(line!);
    line!.traceTo(start);
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

  BaseActorType get actorType => actor.type;

}