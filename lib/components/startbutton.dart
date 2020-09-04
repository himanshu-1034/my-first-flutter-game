import 'package:first_flutter_game/game_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Startbutton{
  final GameController gameController;
  TextPainter painter;
  Offset position;
  Startbutton(this.gameController){
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,

    );
    position = Offset.zero;
  }

  void render(Canvas c){
    painter.paint(c, position);

  }
  void update(double t){

    painter.text = TextSpan(
      text: 'START',
      style: TextStyle(
        color: Colors.black,
        fontSize: 50.0,

      ),
    );
    painter.layout();
    position = Offset(
      (gameController.screensize.width/2) - (painter.width/2),
      (gameController.screensize.height*0.7) - (painter.height/2),
    );
  }
}