
enum GameLayers {
  background,
  enemy,
  indicators,
  player,
  lines,
  ui;
}

extension GameLayersExtension on GameLayers {
  int get layer => index - 1;
}