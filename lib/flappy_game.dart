import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/composants/background.dart';
import 'package:flappy_bird/composants/base.dart';

class FlappyGame extends Game {
  Size screenSize;
  Background background;

  List<Base> baseList;

  //Constructeur
  FlappyGame() {
    initialize();
  }

  // On crée cette fonction pour attendre les dimensions de l'écran avant de lancer la premiere boucle
  void initialize() async {
    resize(await Flame.util.initialDimensions());
    background = Background(this);
    createBase();
  }

  @override
  void render(Canvas canvas) {
    //Ordre des éléments ici très important ---> comme des calques
    background.render(canvas);
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
    }
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
