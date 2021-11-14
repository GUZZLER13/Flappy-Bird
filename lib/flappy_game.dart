import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flame/time.dart';
import 'package:flappy_bird/composants/background.dart';
import 'package:flappy_bird/composants/base.dart';
import 'package:flappy_bird/composants/game_over.dart';
import 'package:flappy_bird/composants/pipes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'composants/bird.dart';
import 'composants/cloud.dart';
import 'composants/options.dart';
import 'composants/rain.dart';
import 'composants/start.dart';

double speedCreatePipes = 1.5;

class FlappyGame extends Game with TapDetector {
  Size screenSize;
  Background background;
  List<Base> baseList;
  List<Rain> rainList;
  List<Pipes> pipeList = [];
  Timer timerPipe;
  Timer timerStart;
  Timer timerStart2;
  Bird bird;
  Cloud cloud;
  GameOverScreen endMessage;
  bool isPlaying = false;
  int score = 0;
  int highScore;
  TextConfig scoreTextConfig;
  SharedPreferences prefs;
  Option option;
  Start start;


  //Constructor
  FlappyGame() {
    initialize();
  }

  //On crée cette fonction pour attendre les dimensions de l'écran avant de lancer la premiere boucle
  void initialize() async {
    resize(await Flame.util.initialDimensions());

    //On récupère le highscore
    getHighScore();

    //fond d'écran
    background = Background(this);

    //pluie
    createRain();

    //Start
    start = Start(this);

    //sol
    createBase();

    //option
    option = Option(this);


    //pipes
    timerPipe = Timer(speedCreatePipes, repeat: true, callback: () {
      Pipes newPipes = Pipes(this);
      pipeList.add(newPipes);
    });

    timerStart = Timer(.5, repeat: true, callback: () {
      start.startRect =   const Rect.fromLTWH(-1000, -1000, 0, 0);

    });

    timerStart2 = Timer(1, repeat: true, callback: () {

      start.startRect =   Rect.fromLTWH(screenSize.width / 2 - 115,
          screenSize.height - screenSize.height / 3.5, 230, 110);
    });


    timerPipe.start();
    timerStart.start();
    timerStart2.start();

    //bird
    bird = Bird(this);

    //Cloud
    cloud = Cloud(this);



    endMessage = GameOverScreen(this, score);

    //initialize TextConfig
    scoreTextConfig = TextConfig(
        fontSize: 70, fontFamily: 'flappy_font', color: Colors.white);
  }

  @override
  void render(Canvas canvas) {

    //Ordre des éléments ici très important ---> comme des calques
    background.render(canvas);




    //Pluie
    for (var element in rainList) {
      element.render(canvas);
    }



    //Cloud
    cloud.render(canvas);

    if (isPlaying) {
      //on affiche le score
      scoreTextConfig.render(canvas, score.toString(),
          Position(screenSize.width / 2, screenSize.height / 8),
          anchor: Anchor.center);
      //on affiche les tubes
      for (var element in pipeList) {
        element.render(canvas);
      }
      //affiche le bird
      bird.render(canvas);
    } else {

      //Start
      start.render(canvas);

      //option
      option.render(canvas);

      endMessage.render(canvas);
    }

    for (var element in baseList) {
      element.render(canvas);
    }


  }

  @override
  void update(double t) {
    if (isPlaying) {

      timerPipe.update(t);


      //déplacement des tubes
      for (var element in pipeList) {
        element.update(t);
      }

      //supprimer les pipes qui ne sont plus visibles de la liste de pipes
      pipeList.removeWhere((element) => !element.isVisible);

      bird.update(t);
      updateScore();
      gameOver();
    }

    timerStart.update(t);
    timerStart2.update(t);

    for (var base in baseList) {
      base.update(t);
    }

    for (var rain in rainList) {
      rain.update(t);
    }

    cloud.update(t);

    //retirer l'element du sol qui n'est plus visible et remettre la liste de bases comme au début (2 bases)
    baseList.removeWhere((element) => !element.isVisible);
    if (baseList.length < 2) {
      createBase();
    }

    //retirer les nuages sortis de l'écran
    if (!cloud.isVisible) {
      cloud = Cloud(this);
    }

    //retirer l'element de la pluiel qui n'est plus visible et remettre la pluie comme au début (4 fois l'image)
    rainList.removeWhere((element) => !element.isVisible);
    if (rainList.length < 5) {
      createRain();
    }

    option.update(t);

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

  void createRain() {
    rainList = [];
    Rain firstRain = Rain(this, 0, 0);
    Rain secondRain = Rain(this, screenSize.width, 0);
    Rain thirdRain = Rain(this, 0, -screenSize.height);
    Rain fourthRain = Rain(this, screenSize.width, -screenSize.height);
    Rain fiveRain = Rain(this, screenSize.width * 2, 0);
    Rain sixRain = Rain(this, screenSize.width * 2, -screenSize.height);

    rainList.add(thirdRain);
    rainList.add(fourthRain);
    rainList.add(secondRain);
    rainList.add(firstRain);
    rainList.add(fiveRain);
    rainList.add(sixRain);
  }

  @override
  void onTap() {
    super.onTap();
    if (isPlaying) {
      bird.onTap();
    } else {
      pipeList.clear();
      isPlaying = true;
      timerPipe.start();
    }
  }




  void gameOver() {
    //check si le bird touche les tubes
    for (var element in pipeList) {
      if (element.hasCollided(bird.birdRect)) {
        // Flame.audio.play('hit.wav');
        playAudio('hit.wav');

        reset();
      }
    }
    //check si le bird touche le sol
    for (var element in baseList) {
      if (element.hasCollided(bird.birdRect)) {
        // Flame.audio.play('hit.wav');
        playAudio('hit.wav');

        reset();
      }
    }
    //check si le bird touche le "plafond"
    if (bird.birdRect.top <= 0) {
      // Flame.audio.play('hit.wav');
      playAudio('hit.wav');

      reset();
    }
  }

  void reset() {
    isPlaying = false;
    timerPipe.stop();
    bird = Bird(this);

    endMessage = GameOverScreen(this, score);
    score = 0;
    scoreTextConfig = TextConfig(
        fontSize: 70, fontFamily: 'flappy_font', color: Colors.white);
  }

  void updateScore() {
    for (var pipes in pipeList) {
      if (pipes.canUpdateScore == true) {
        if (bird.birdRect.right >=
            pipes.topPipeBodyRect.left + pipes.topPipeBodyRect.width / 2) {
          score++;
          Flame.audio.play('point.wav');
          pipes.canUpdateScore = false;

          // update le meilleur score
          if (score > highScore) {
            print('le score est meilleur que le highscore!!!');
            scoreTextConfig = TextConfig(
                fontSize: 70, fontFamily: 'flappy_font', color: Colors.red);
            saveHighScore();
          }
        }
      }
    }
  }

  void saveHighScore() async {
    highScore = score;
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('highScore', highScore);
  }

  void getHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    highScore = prefs.getInt('highScore') ?? 0;
    print('le score le meilleur : $highScore');
  }

  void playAudio(String sound) async {
    await Flame.audio.play(sound);
  }
}
