
import 'package:bandit/game/components/actors/base_actor.dart';
import 'package:bandit/game/components/dasher/can_dash_mixin.dart';
import 'package:bandit/game/components/dasher/kill_line/kill_line.dart';
import 'package:flame/components.dart';

class KillLinePool extends Component {

  static const double defaultLineLife = 0.4;

  final double lineLife;

  KillLine? line;
  CanDashActor actor;

  final List<KillLine> pool = [];
  final int poolSize; // Counts the current line as well

  KillLinePool({
    required this.actor,
    this.lineLife = KillLinePool.defaultLineLife,
    this.poolSize = 3
  }) : assert(poolSize >= 1), super(
    // position: Vector2.zero(),
  );
  

  KillLine startLine(Vector2 start){
    removeTracingLine();
    if(pool.length >= poolSize) untrackLine();
    line = KillLine(start: start);
    add(line!);
    line!.traceTo(start);
    return line!;
  }

  void traceLine(Vector2 end){
    if(line == null) return;
    line!.traceTo(end);
  }

  void endLine(){
    if(line == null) return;
    line!.stop();
    
    trackLine(line!);
    line = null;
  }

  // just in case there is a unfinished line
  void removeTracingLine(){
    if(line == null) return;
    endLine();
  }

  void trackLine(KillLine newLine){
    pool.add(newLine);

    // Removes this line after the delay
    // start a timer for the line life and then remove the line
    newLine.fadeAway(lineLife, () => untrackLine(newLine));
  }

  void untrackLine([KillLine? line]){
    int index = line == null ? 0 : pool.indexOf(line);
    if(index == -1) return;
    final removeLine = pool.removeAt(index);
    removeLine.clear();
    remove(removeLine);
  }

  void clear(){
    removeTracingLine();
  }

  bool get hasActiveLine => line != null && line!.drawing;

  BaseActorType get actorType => actor.type;

}