import 'dart:ui';

import 'package:flame/sprite.dart';

import '../flappy_game.dart';

class Background {
  //déclaration variables
  Rect bgRect;
  Sprite bgSprite;
  final FlappyGame game;

  //Constructeur
  Background(this.game) {
    bgSprite = Sprite('background.png');
    bgRect = Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
  }

  void update(double t) {}

  void render(Canvas canvas) {
    bgSprite.renderRect(canvas, bgRect);
  }
}
