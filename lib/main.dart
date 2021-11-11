import 'package:flame/util.dart';
import 'package:flappy_bird/flappy_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();

  //Forcer mode plein écran
  flameUtil.fullScreen();

  //Forcer mode portrait
  flameUtil.setOrientation(DeviceOrientation.portraitUp);

  //Création d'une instance de la classe FlappyGame
  FlappyGame game = FlappyGame();

  runApp(game.widget);

}


