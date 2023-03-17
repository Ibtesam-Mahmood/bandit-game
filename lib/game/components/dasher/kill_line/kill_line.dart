
import 'package:bandit/game/components/dasher/kill_line/kill_line_pool.dart';
import 'package:bandit/game/util/game_layers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class KillLine extends PolygonHitbox {

  final Vector2 start;
  Vector2? end;
  bool drawing = false;

  static List<Vector2> baseVerticesAt(Vector2 pos) => [pos, pos, pos, pos];

  List<Vector2> get baseVertices => baseVerticesAt(start);

  KillLine({
    required this.start, 
  }) : super(baseVerticesAt(start), position: Vector2.zero());

  @override
  Future<void>? onLoad() async {

    priority = GameLayers.lines.layer;

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    
    if(end == null) return; // Don't render if there is no line to draw

    final bottomLeft = parentToLocal(start).toOffset();
    final bottomRight = parentToLocal(end!).toOffset();
    // final topLeft = parentToLocal(vertices[2]).toOffset();
    // final topRight = parentToLocal(vertices[3]).toOffset();
    canvas.drawLine(bottomLeft, bottomRight, _paint);
    // canvas.drawLine(Offset(10, 10), Offset(20, 20), _paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // updateHitbox();
  }

  Paint get _paint => Paint()
    ..shader = const LinearGradient(colors: [Colors.white, Colors.green], begin: Alignment.topLeft, end: Alignment.bottomRight).createShader(Rect.fromPoints(start.toOffset(), end!.toOffset()))
    // ..color = Colors.white.withOpacity(1.0)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  KillLinePool get pool {
    assert(parent is KillLinePool, 'KillLine must be added to a KillLinePool');
    return parent as KillLinePool;
  }

  void updateHitbox(){
    if(vertices[1] == end || !drawing) return;

    late List<Vector2> newVertices;
    if(end == null && vertices[1] != start){
      newVertices = baseVertices;
      stop();
    }
    else{
      final perpendicular = ((end! - start).normalized()..y *= -1) * _paint.strokeWidth;
      newVertices = [start, end!, end! + perpendicular, start + perpendicular];
    }
    
    refreshVertices(newVertices: newVertices);
    position = Vector2.zero();
  }

  void clear(){
    end = null;
  }

  void traceTo(Vector2 newEnd) {
    drawing = true;
    end = newEnd;
  }

  void stop() {
    drawing = false;
  }
}