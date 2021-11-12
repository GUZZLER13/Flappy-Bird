import 'dart:ui';

import 'package:flame/sprite.dart';

import '../flappy_game.dart';

class Bird {
  Rect birdRect;
  Sprite birdSprite;

  final FlappyGame game;

  Bird(this.game) {
    birdSprite = Sprite('midflap.png');
    birdRect = Rect.fromLTWH(50, game.screenSize.height / 2, 50, 35);
  }

  void update(double t) {}

  void render(Canvas canvas) {
    birdSprite.renderRect(canvas, birdRect);
  }
}
