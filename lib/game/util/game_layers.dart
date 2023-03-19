
enum GameLayers {
  background,
  enemy,
  indicators,
  lines,
  player,
  ui;
}

extension GameLayersExtension on GameLayers {
  int get layer => index - 1;
}