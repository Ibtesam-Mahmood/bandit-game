
enum GameLayers {
  background,
  enemy,
  player,
  ui;
}

extension GameLayersExtension on GameLayers {
  int get layer => index - 1;
}