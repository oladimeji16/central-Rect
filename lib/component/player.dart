import 'package:flutter/cupertino.dart';
import 'package:hit_the_block/game_controller.dart';

class Player {
  final GameController gameController;
  int maxHealth;
  int currentHealth;
  Rect playerRect;
  bool isDead = false;

  Player(this.gameController) {
    maxHealth = currentHealth = 500;
    final size = gameController.tileSize * 1.5;
    playerRect = Rect.fromLTWH(gameController.screenSize.width / 2 - size / 2,
        gameController.screenSize.height / 2 - size / 2,
        size,
        size
    );
  }

  void render(Canvas c) {
    Paint color = Paint()..color = Color(0xFF008080);
    c.drawRect(playerRect, color);

  }

  void update(double t){
    if (!isDead && currentHealth <= 0) {
      isDead = true;
      gameController.initialize();
    }
  }
}