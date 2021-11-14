import 'package:flame/sprite.dart';
import 'package:flappy_bird/flappy_game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Option {
  Rect rectOption;
  Sprite spriteOption;
  final FlappyGame game;
  double optionMove = 0;

  Option(this.game) {
    rectOption = Rect.fromLTWH(
        game.screenSize.width / 12, game.screenSize.height / 27, 50, 50);
    spriteOption = Sprite('option.png');
  }

  void update(double t) {
// if (rectOption.left == game.screenSize.width / 10 +2) {
//   rectOption = rectOption.translate(-2, -2);
// } else {
//   rectOption = rectOption.translate(0.5, 0.5);
// }

    optionMove += 0.5;
  }

  void render(Canvas canvas) {
    // save canvas stats
    canvas.save();
    // deplace l'origine du canvas
    canvas.translate(rectOption.left + (rectOption.width / 2),
        rectOption.top + (rectOption.height / 2));
    // applique la rotation
    canvas.rotate(optionMove * 0.005);
    //affiche le sprite
    spriteOption.renderRect(
        canvas, Rect.fromLTWH(-rectOption.width/2, -rectOption.height/2, rectOption.width, rectOption.height));

    //restore l'état du canvas à son état d'origine
    canvas.restore();
  }
}
