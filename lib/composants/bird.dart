import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/time.dart';

import '../flappy_game.dart';

const double GRAVITY = 0.25;
const double BIRD_HEIGHT = 35;
const double BIRD_WDTH = 50;

class Bird {
  Rect birdRect;
  Sprite birdSprite;
  final FlappyGame game;
  List<Sprite> sprites;
  int spriteIndex = 0;
  Timer timer;
  double birdMovement = 0;
  bool isJumping = false;

  Bird(this.game) {
    sprites = [
      Sprite('downflap.png'),
      Sprite('midflap.png'),
      Sprite('upflap.png')
    ];

    timer = Timer(0.1, repeat: true, callback: () {
      spriteIndex += 1;
    });

    timer.start();
    birdRect =
        Rect.fromLTWH(50, game.screenSize.height / 2, BIRD_WDTH, BIRD_HEIGHT);
  }

  void update(double t) {
    timer.update(t);
    if (isJumping) {
      birdMovement = -5;
      isJumping = false;
    } else {
      birdMovement = birdMovement + GRAVITY;
    }

    birdRect = birdRect.translate(0, birdMovement);

  }

  void render(Canvas canvas) {
    if (spriteIndex == 3) {
      spriteIndex = 0;
    }
    birdSprite = sprites[spriteIndex];

    //save Canvas State
    // canvas.save();

    //deplace l'origine du canvas
    // canvas.translate(
    //     50 + (BIRD_WDTH / 2), birdRect.bottom - (BIRD_HEIGHT / 2));

    //applique la rotation
    // canvas.rotate(birdMovement * 0.06);

    // on affiche le bird
    // birdSprite.renderRect(canvas, const Rect.fromLTWH(0, 0, BIRD_WDTH, BIRD_HEIGHT));
    birdSprite.renderRect(canvas, birdRect);


    //restore l'etat du canvas
    // canvas.restore();
  }

  void onTap() {
    // Flame.audio.play('wing.wav');
    game.playAudio('wing.wav');

    isJumping = true;
  }
}
