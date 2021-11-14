import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';

import '../flappy_game.dart';

class GameOverScreen {
  Rect messageRect;
  Sprite messageSprite;
  final FlappyGame game;
  final int score;
  // int highScore;
  TextConfig scoreTextConfig;
  TextConfig highScoreTextConfig;

  GameOverScreen(this.game, this.score) {
    game.getHighScore();
    messageSprite = Sprite('message.png');
    messageRect = Rect.fromCenter(
        center: Offset(game.screenSize.width / 2, game.screenSize.height / 2),
        width: 276,
        height: 400);

    scoreTextConfig = TextConfig(
        fontFamily: 'flappy_font', fontSize: 45, color: Colors.white);
    highScoreTextConfig =
        TextConfig(fontFamily: 'flappy_font', fontSize: 40, color: Colors.red);

  }

  void update(double t) {}

  void render(Canvas canvas) {
    if (score == 0) {
      scoreTextConfig.render(canvas, '', Position(0, 0));
      highScoreTextConfig.render(canvas, 'HighScore : ${game.highScore ?? 0}',
          Position(game.screenSize.width / 2, game.screenSize.height / 9.5),
          anchor: Anchor.center);
    } else {
      highScoreTextConfig.render(
          canvas,
          'HighScore : ${game.highScore ?? 0}',
          Position(game.screenSize.width / 2,
              game.screenSize.height - game.screenSize.height / 6),
          anchor: Anchor.center);
      scoreTextConfig.render(canvas, 'Score : $score',
          Position(game.screenSize.width / 2, game.screenSize.height / 9.5),
          anchor: Anchor.center);
    }
    messageSprite.renderRect(canvas, messageRect);
  }
}
