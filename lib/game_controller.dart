import 'dart:math';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hit_the_block/component/enemy.dart';
import 'package:hit_the_block/component/healthBar.dart';
import 'package:hit_the_block/component/highscoreText.dart';
import 'package:hit_the_block/component/howToPlay.dart';
import 'package:hit_the_block/component/player.dart';
import 'package:hit_the_block/component/score.dart';
import 'package:hit_the_block/component/startButton.dart';
import 'package:hit_the_block/enemy_spwaner.dart';
import 'package:hit_the_block/state.dart' as GameState;
import 'package:shared_preferences/shared_preferences.dart';



const String testDevice = '';
class GameController extends Game {
  final SharedPreferences storage;
  Random  rand;
  Size screenSize;
  double tileSize;
  Player player;
  EnemySpawner enemySpawner;
  List<Enemy> enemies;
  HealthBar healthBar;
  int score;
  ScoreText scoreText;
  GameState.State state;
  HighscoreText highScoreText;
  StartButton startText;
  HowToPlay howToPlayText;


  GameController(this.storage) {
    initialize();
  }

  void initialize() async{
    resize(await Flame.util.initialDimensions());
    state = GameState.State.menu;
    rand = Random();
    player = Player(this);
    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);
    healthBar = HealthBar(this);
    score = 0;
    scoreText = ScoreText(this);
    highScoreText = HighscoreText(this);
    startText = StartButton(this);
    howToPlayText = HowToPlay(this);
  }

  void render(Canvas c){
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);
    player.render(c);


    if(state == GameState.State.menu) {
      // Start Button and highscore
      startText.render(c);
      highScoreText.render(c);
      howToPlayText.render(c);
    }else if(state == GameState.State.playing ){
    enemies.forEach((Enemy enemy) => enemy.render(c));
    scoreText.render(c);
    healthBar.render(c);


    }

  }
  void update(double t){
    if(state == GameState.State.menu) {
      // Start Button and highscore
      startText.update(t);
      highScoreText.update(t);
      howToPlayText.update(t);
    }else if (state == GameState.State.playing){
    enemySpawner.update(t);
    enemies.forEach((Enemy enemy) => enemy.update(t));
    enemies.removeWhere((Enemy enemy) => enemy.isDead);
    player.update(t);
    scoreText.update(t);
    healthBar.update(t);
    }

  }
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }

  void onTapDown(TapDownDetails d) {
    if (state == GameState.State.menu) {
      state = GameState.State.playing;
    } else if(state == GameState.State.playing) {
      enemies.forEach((Enemy enemy) {
        if (enemy.enemyRect.contains(d.globalPosition)) {
          enemy.onTapDown();
        }
      });
    }
  }

  void spawnEnemy() {
    double x, y;
    switch(rand.nextInt(4)) {
      case 0:
        // top
        x = rand.nextDouble() * screenSize.width;
        y = - tileSize * 2.5;
        break;
      case 1:
        // right
        x = screenSize.width + tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
      case 2:
        // bottom
        x = rand.nextDouble() * screenSize.width;
        y = screenSize.height + tileSize * 2.5;
        break;
      case 3:
        //left
        x = - tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
    }

    enemies.add(Enemy(this,x,y));
  }

}