import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flappy_bird/flappy_game.dart';

class Cloud {
  Rect cloudRect;
  Sprite cloudSprite;
  final FlappyGame game;
  bool isVisible = true;

  Cloud(this.game) {
    cloudSprite = Sprite('cloud.png');
    cloudRect = Rect.fromLTWH(
        game.screenSize.width, 0, game.screenSize.width / 1.5, game.screenSize.height / 3);
  }

  void update(double t) {
    cloudRect = cloudRect.translate(-0.15, 0);
    //si le rectangle de droite sort de l'écran
    if (cloudRect.right <= 0) {
      isVisible = false;
    }
  }

  void render(Canvas canvas) {
    cloudSprite.renderRect(canvas, cloudRect);
  }
}
