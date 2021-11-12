import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/time.dart';
import 'package:flappy_bird/composants/background.dart';
import 'package:flappy_bird/composants/base.dart';
import 'package:flappy_bird/composants/pipes.dart';
import 'package:flutter/cupertino.dart';

import 'composants/bird.dart';

double speedCreatePipes = 2;

class FlappyGame extends Game with TapDetector {
  Size screenSize;
  Background background;
  List<Base> baseList;
  List<Pipes> pipeList = [];
  Timer timer;
  Bird bird;

  //Constructor
  FlappyGame() {
    initialize();
  }

  // On crée cette fonction pour attendre les dimensions de l'écran avant de lancer la premiere boucle
  void initialize() async {
    resize(await Flame.util.initialDimensions());
    //fond d'écran
    background = Background(this);
    //sol
    createBase();
    //pipes
    timer = Timer(speedCreatePipes, repeat: true, callback: () {
      Pipes newPipes = Pipes(this);
      pipeList.add(newPipes);
    });
    //bird
    bird = Bird(this);

    timer.start();
  }

  @override
  void render(Canvas canvas) {
    //Ordre des éléments ici très important ---> comme des calques
    background.render(canvas);
    for (var element in pipeList) {
      element.render(canvas);
    }
    for (var element in baseList) {
      element.render(canvas);
    }

    //affiche le bird
    bird.render(canvas);
  }

  @override
  void update(double t) {
    timer.update(t);

    //déplacement des tubes
    for (var element in pipeList) {
      element.update(t);
    }

    //supprimer les pipes qui ne sont plus visibles de la liste de pipes
    pipeList.removeWhere((element) => !element.isVisible);

    for (var base in baseList) {
      base.update(t);
    }

    //retirer l'element du sol qui n'est plus visible et remettre la liste de bases comme au début (2 bases)
    baseList.removeWhere((element) => !element.isVisible);
    if (baseList.length < 2) {
      createBase();
    }

    bird.update(t);
    gameOver();
  }

  @override
  void resize(Size size) {
    super.resize(size);
    screenSize = size;
  }

  void createBase() {
    baseList = [];
    Base firstBase = Base(this, 0);
    Base secondBase = Base(this, screenSize.width);
    baseList.add(firstBase);
    baseList.add(secondBase);
  }

  @override
  void onTap() {
    super.onTap();
    print('onTap');
    bird.onTap();
  }

  void gameOver() {
    //check si le bird touche les tubes
    for (var element in pipeList) {
      if (element.hasCollided(bird.birdRect)) {
        print('on a touché un tube');
      }
    }
    //check si le bird touche le sol
    for (var element in baseList) {
      if (element.hasCollided(bird.birdRect)) {
        print('on a touché le sol');
      }
    }
    //check si le bird touche le "plafond"
    if (bird.birdRect.top <= 0) {
      print('on a touché le plafond');
    }
  }
}
