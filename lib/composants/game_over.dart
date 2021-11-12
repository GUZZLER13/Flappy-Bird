import 'dart:ui';

import 'package:flame/sprite.dart';

import '../flappy_game.dart';

class GameOverScreen {
  Rect messageRect;
  Sprite messageSprite;
  final FlappyGame game;

  GameOverScreen(this.game) {
    messageSprite = Sprite ('background.png');
  }



  void update(double t) {}

  void render(Canvas canvas) {}
}
