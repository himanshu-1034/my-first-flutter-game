import 'package:first_flutter_game/game_controller.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
class Player{
  final GameController gameController;
  int maxhealth;
  int currenthealth;
  Rect playerrect;
  bool isdead  = false;
  Player(this.gameController){
    maxhealth = currenthealth = 300;
    final size = gameController.tilesize * 1.5;
    playerrect = Rect.fromLTWH(gameController.screensize.width/2 - size/2, gameController.screensize.height/2 - size/2, size, size);

  }
  void render(Canvas c){
    Paint color = Paint()..color=Color(0xff0000ff);
    c.drawRect(playerrect, color);
  }

  void update(double t){
    if(!isdead && currenthealth<=0){
      isdead=true;
      gameController.initialize();
    }
  }
}