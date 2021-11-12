import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/time.dart';
import 'package:flappy_bird/composants/background.dart';
import 'package:flappy_bird/composants/base.dart';
import 'package:flappy_bird/composants/pipes.dart';
import 'package:flutter/cupertino.dart';

import 'composants/bird.dart';

class FlappyGame extends Game {
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
    timer = Timer(2, repeat: true, callback: () {
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

    for (var base in baseList) {
      base.update(t);
    }

    //retirer l'element du sol qui n'est plus visible et remettre la liste de bases comme au début (2 bases)
    baseList.removeWhere((element) => !element.isVisible);
    if (baseList.length < 2) {
      createBase();
    }

    //déplacement des tubes
    for (var element in pipeList) {
      element.update(t);
    }

    //supprimer les pipes qui ne sont plus visibles de la liste de pipes
    pipeList.removeWhere((element) => !element.isVisible);

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
