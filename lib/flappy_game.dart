import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/composants/background.dart';
import 'package:flappy_bird/composants/base.dart';

class FlappyGame extends Game {
  Size screenSize;
  Background background;
  Base base;

  //Constructeur
  FlappyGame() {
    initialize();
  }

  // On crée cette fonction pour attendre les dimensions de l'écran avant de lancer la premiere boucle
  void initialize() async{
    resize(await Flame.util.initialDimensions());
    background = Background(this);
    base = Base(this);
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);
    base.render(canvas);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  @override
  void resize(Size size) {
    super.resize(size);
    screenSize = size;
  }
}
