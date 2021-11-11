import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flappy_bird/flappy_game.dart';

const double PIPE_WIDTH = 70;
const double PIPE_HEAD_HEIGHT = 24;
const double PIPE_MOVEMENT = 130;
const double SPACE_BETWEEN_PIPES = 180;
const double topPipeBodyHeight = 300;

class Pipes {
  //haut
  Rect topPipeBodyRect;
  Rect topPipeHeadRect;
  Sprite topPipeBodySprite;
  Sprite topPipeHeadSprite;

  //bas
  Rect bottomPipeBodyRect;
  Rect bottomPipeHeadRect;
  Sprite bottomPipeBodySprite;
  Sprite bottomPipeHeadSprite;

  final FlappyGame game;

  Pipes(this.game) {
    topPipeBodySprite = Sprite('pipe_body.png');
    topPipeHeadSprite = Sprite('pipe_head.png');
    bottomPipeBodySprite = Sprite('pipe_body.png');
    bottomPipeHeadSprite = Sprite('pipe_head.png');

    //RECT du pipe du haut
    topPipeBodyRect = Rect.fromLTWH(
        game.screenSize.width / 2, 0, PIPE_WIDTH, topPipeBodyHeight);
    topPipeHeadRect = Rect.fromLTWH(game.screenSize.width / 2,
        topPipeBodyHeight, PIPE_WIDTH + 2, PIPE_HEAD_HEIGHT);

    // RECT du pipe du bas
    bottomPipeBodyRect = Rect.fromLTWH(
        game.screenSize.width / 2,
        topPipeBodyHeight + PIPE_HEAD_HEIGHT * 2 + SPACE_BETWEEN_PIPES,
        PIPE_WIDTH + 2,
        topPipeBodyHeight);
    bottomPipeHeadRect = Rect.fromLTWH(
        game.screenSize.width / 2,
        topPipeBodyHeight + PIPE_HEAD_HEIGHT + SPACE_BETWEEN_PIPES,
        PIPE_WIDTH + 2,
        PIPE_HEAD_HEIGHT);
  }

  void update(double t) {
    bottomPipeBodyRect = bottomPipeBodyRect.translate(-t * PIPE_MOVEMENT, 0);
    bottomPipeHeadRect = bottomPipeHeadRect.translate(-t * PIPE_MOVEMENT, 0);
    topPipeBodyRect = topPipeBodyRect.translate(-t * PIPE_MOVEMENT, 0);
    topPipeHeadRect = topPipeHeadRect.translate(-t * PIPE_MOVEMENT, 0);
  }

  void render(Canvas canvas) {
    //affiche le body du top pipe
    topPipeBodySprite.renderRect(canvas, topPipeBodyRect);

    //affiche la tête du top pipe
    topPipeHeadSprite.renderRect(canvas, topPipeHeadRect);

    //affiche le body du bottom pipe
    bottomPipeBodySprite.renderRect(canvas, bottomPipeBodyRect);

    //affiche la tête du bottom pipe
    bottomPipeHeadSprite.renderRect(canvas, bottomPipeHeadRect);
  }
}
