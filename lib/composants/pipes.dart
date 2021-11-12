import 'dart:math';
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flappy_bird/flappy_game.dart';

const double PIPE_WIDTH = 70;
const double PIPE_HEAD_HEIGHT = 24;
const double PIPE_MOVEMENT = 130;
const double SPACE_BETWEEN_PIPES = 180;

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

  List<double> heights;

  final FlappyGame game;

  bool isVisible = true;

  //Constructor
  Pipes(this.game) {
    //on initialise la liste des hauteurs
    heights = [
      game.screenSize.height / 6,
      game.screenSize.height / 4,
      game.screenSize.height / 3,
      game.screenSize.height / 2,
      game.screenSize.height / 3.5,
      game.screenSize.height / 5.8,
      game.screenSize.height / 2.4,
      game.screenSize.height / 6.3,
      game.screenSize.height / 4.7,
      game.screenSize.height / 2.8,
      game.screenSize.height / 3.9,
      game.screenSize.height / 4.2,
      game.screenSize.height / 5.3,
      game.screenSize.height / 2.1
    ];

    int index = Random().nextInt(heights.length);
    topPipeBodySprite = Sprite('pipe_body.png');
    topPipeHeadSprite = Sprite('pipe_head.png');
    bottomPipeBodySprite = Sprite('pipe_body.png');
    bottomPipeHeadSprite = Sprite('pipe_head.png');

    double topPipesBodyHeight = heights[index];

    //RECT du pipe du haut
    topPipeBodyRect = Rect.fromLTWH(
        game.screenSize.width + 10, 0, PIPE_WIDTH, topPipesBodyHeight);
    topPipeHeadRect = Rect.fromLTWH(game.screenSize.width + 10,
        topPipesBodyHeight, PIPE_WIDTH + 2, PIPE_HEAD_HEIGHT);

    // RECT du pipe du bas
    bottomPipeBodyRect = Rect.fromLTWH(
        game.screenSize.width + 10,
        topPipesBodyHeight + PIPE_HEAD_HEIGHT * 2 + SPACE_BETWEEN_PIPES,
        PIPE_WIDTH,
        game.screenSize.height -
            (topPipesBodyHeight + PIPE_HEAD_HEIGHT * 2 + SPACE_BETWEEN_PIPES));
    bottomPipeHeadRect = Rect.fromLTWH(
        game.screenSize.width + 10,
        topPipesBodyHeight + PIPE_HEAD_HEIGHT + SPACE_BETWEEN_PIPES,
        PIPE_WIDTH + 2,
        PIPE_HEAD_HEIGHT);
  }

  void update(double t) {
    bottomPipeBodyRect = bottomPipeBodyRect.translate(-t * PIPE_MOVEMENT, 0);
    bottomPipeHeadRect = bottomPipeHeadRect.translate(-t * PIPE_MOVEMENT, 0);
    topPipeBodyRect = topPipeBodyRect.translate(-t * PIPE_MOVEMENT, 0);
    topPipeHeadRect = topPipeHeadRect.translate(-t * PIPE_MOVEMENT, 0);

    // on vérifie si le tube est sorti
    if (topPipeHeadRect.right < 0) {
      isVisible = false;
    }
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
