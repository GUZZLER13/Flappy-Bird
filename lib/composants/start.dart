import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flappy_bird/flappy_game.dart';

class Start {
  Rect startRect;
  Sprite startSprite;

  final FlappyGame game;

  Start(this.game) {
    startRect = Rect.fromLTWH(game.screenSize.width / 2 - 115,
        game.screenSize.height - game.screenSize.height / 3.5, 230, 110);
    startSprite = Sprite('start.png');
  }

  void update(double t) {}

  void render(Canvas canvas) {

    startSprite.renderRect(canvas, startRect);
  }
}
