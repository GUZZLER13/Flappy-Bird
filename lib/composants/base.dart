import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flappy_bird/flappy_game.dart';

class Base {
  Rect baseRect;
  Sprite baseSprite;
  final FlappyGame game;

  Base(this.game) {
    baseSprite = Sprite('base.png');
    baseRect = Rect.fromLTWH(0, game.screenSize.height - game.screenSize.height/8, game.screenSize.width, game.screenSize.height/8);
  }

  void update(double t) {

  }

  void render(Canvas canvas) {
    baseSprite.renderRect(canvas, baseRect);
  }
}
