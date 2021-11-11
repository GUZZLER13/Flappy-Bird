import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flappy_bird/flappy_game.dart';

const double BASE_MOVEMENT = 130;

class Base {
  Rect baseRect;
  Sprite baseSprite;
  final FlappyGame game;
  final double leftPosition;
  bool isVisible = true;

  Base(this.game, this.leftPosition) {
    baseSprite = Sprite('base.png');
    baseRect = Rect.fromLTWH(
        leftPosition,
        game.screenSize.height - game.screenSize.height / 8,
        game.screenSize.width,
        game.screenSize.height / 8);
  }

  void update(double t) {
    baseRect = baseRect.translate(-t * BASE_MOVEMENT, 0);
    //si le rectangle de droite sort de l'écran
    if (baseRect.right <= 0) {
      isVisible = false;
    }
  }

  void render(Canvas canvas) {
    baseSprite.renderRect(canvas, baseRect);
  }
}
