import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/composants/background.dart';
import 'package:flappy_bird/composants/base.dart';
import 'package:flappy_bird/composants/pipes.dart';
import 'package:flutter/cupertino.dart';

class FlappyGame extends Game {
  Size screenSize;

  Background background;

  List<Base> baseList;

  Pipes pipes;

  //Constructeur
  FlappyGame() {
    initialize();
  }

  // On crée cette fonction pour attendre les dimensions de l'écran avant de lancer la premiere boucle
  void initialize() async {
    resize(await Flame.util.initialDimensions());
    background = Background(this);
    createBase();
    pipes = Pipes(this);
  }

  @override
  void render(Canvas canvas) {
    //Ordre des éléments ici très important ---> comme des calques
    background.render(canvas);
    pipes.render(canvas);
    for (var element in baseList) {
      element.render(canvas);
    }
  }

  @override
  void update(double t) {
    for (var element in baseList) {
      element.update(t);
    }
    baseList.removeWhere((element) => !element.isVisible);
    if (baseList.length == 1) {
      createBase();

      //déplacement des tubes

    }
    pipes.update(t);
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
}
