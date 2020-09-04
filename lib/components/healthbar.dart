import 'package:first_flutter_game/game_controller.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
class Healthbar{
  final GameController gameController;
  Rect healthbarrect;
  Rect remaininghealthrect;
  Healthbar(this.gameController){
    double barwidth = gameController.screensize.width/1.75;
    healthbarrect = Rect.fromLTWH(gameController.screensize.width/2 - barwidth/2, gameController.screensize.height*0.8, barwidth, gameController.tilesize*0.5);
    remaininghealthrect = Rect.fromLTWH(gameController.screensize.width/2 - barwidth/2, gameController.screensize.height*0.8, barwidth, gameController.tilesize*0.5);
  }

  void render(Canvas c){
    Paint healthbarcolor = Paint()..color = Color(0xffff0000);
    Paint remaininghealthcolor = Paint()..color = Color(0xff00ff00);
    c.drawRect(healthbarrect, healthbarcolor);
    c.drawRect(remaininghealthrect, remaininghealthcolor);
  }
  void update(double t){
        double barwidth = gameController.screensize.width / 1.75;
        double percenthealth = gameController.player.currenthealth / gameController.player.maxhealth;
        remaininghealthrect =  Rect.fromLTWH(gameController.screensize.width/2 - barwidth/2, gameController.screensize.height*0.8, barwidth*percenthealth , gameController.tilesize*0.5);
  }


}