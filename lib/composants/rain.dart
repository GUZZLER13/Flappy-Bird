import 'dart:ui';

import 'package:flame/sprite.dart';

import '../flappy_game.dart';

class Rain {
  Rect rainRect;
  Sprite rainSprite;
  final FlappyGame game;
  final double leftPosition;
  final double topPosition;
  bool isVisible = true;

  Rain(this.game, this.leftPosition, this.topPosition) {
    rainSprite = Sprite('rain.png');
    rainRect = Rect.fromLTWH(leftPosition, topPosition, game.screenSize.width,
        game.screenSize.height);
  }

  void update(double t) {
    rainRect = rainRect.translate(-t * 500, t * 1300);
//si le rectangle de droite sort de l'écran
    if (rainRect.right <= 100) {
      isVisible = false;
    }
  }

  void render(Canvas canvas) {
    rainSprite.renderRect(canvas, rainRect);
  }
}
