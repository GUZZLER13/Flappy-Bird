import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/composants/background.dart';

class FlappyGame extends Game {
  Size screenSize;
  Background background;

  //Constructeur
  FlappyGame() {
    initialize();

  }

  void initialize() async{
    resize(await Flame.util.initialDimensions());
    background = Background(this);
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);
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
