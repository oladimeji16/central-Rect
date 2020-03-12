import 'package:hit_the_block/component/enemy.dart';
import 'package:hit_the_block/game_controller.dart';

class EnemySpawner {
  final GameController gameController;
  final int maxSpawnInterval = 2000;
  final int minSpawnInterval = 500;
  final int intervalChange = 3;
  final int maxEnemies = 10;
  int currentInterval;
  int nextSpawn;

  EnemySpawner(this.gameController) {
    killEnemies();
    initialize();
  }

  void initialize() {
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killEnemies() {
    gameController.enemies.forEach((Enemy enemy) => enemy.isDead = true);
  }

  void update(double t) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if(gameController.enemies.length < maxEnemies && now >= nextSpawn) {
      gameController.spawnEnemy();
      if(currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * 0.3).toInt();
      }
      nextSpawn = now + currentInterval;
    }
  }
}