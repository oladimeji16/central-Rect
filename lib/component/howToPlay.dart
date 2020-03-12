import 'package:flutter/material.dart';
import 'package:hit_the_block/game_controller.dart';

class  HowToPlay {
  final GameController gameController;
  TextPainter painter1;
  TextPainter painter2;
  Offset position1;
  Offset position2;

  HowToPlay(this.gameController) {
    painter1 = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    painter2 = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    position1 = Offset.zero;
    position2 = Offset.zero;
  }

  void render(Canvas c) {
    painter1.paint(c, position1);
    painter2.paint(c, position2);

  }

  void update(double t) {
    painter1.text = TextSpan(text: 'HOW TO PLAY:',
        style: TextStyle(color: Colors.red, fontSize: 25.0));
    painter1.layout();

    painter2.text = TextSpan(text: 'The aim of the game is to protect the\n Centre Rect,'
        '\nThe health bar decreases as long as there \nis a red rect touching the Green one.\n'
        '\nTap twice on the red boxes to kill them.'
        '\nEnjoy',
        style: TextStyle(color: Colors.blueGrey, fontSize: 18.0,));
    painter2.layout();

    position1 = Offset(
      (gameController.screenSize.width / 2) - (painter1.width / 2),
      (gameController.screenSize.height * 0.7) - (painter1.height * 0.2),
    );

    position2 = Offset(
      (gameController.screenSize.width / 2.7) - (painter2.width / 2.7),
      (gameController.screenSize.height * 0.8) - (painter2.height * 0.2),
    );

  }
}