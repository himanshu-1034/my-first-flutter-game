import 'package:first_flutter_game/game_controller.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
class Enemy{
  final GameController gameController;
  int health;
  int damage;
  double speed;
  Rect enemyrect;
  bool isdead = false;
  Enemy(this.gameController , double x,double y){
    health = 3;
    damage = 1;
    speed = gameController.tilesize * 2;
    enemyrect = Rect.fromLTWH(x, y, gameController.tilesize*1.2, gameController.tilesize*1.2);
  }

  void update(double t){
    if(!isdead){
      double stepdistance = speed * t;
      Offset toplayer = gameController.player.playerrect.center - enemyrect.center;
      if(stepdistance <= (toplayer.distance - gameController.tilesize*1.25) )
        {
          Offset steptoplayer = Offset.fromDirection(toplayer.direction , stepdistance);
          enemyrect = enemyrect.shift(steptoplayer);
        }
      else{
        attack();
      }
    }
  }

  void render(Canvas c){
    Color color;
    switch(health)
    {
      case 1:
        color = Color(0xffff7f7f);
        break;
      case 2:
        color = Color(0xffff4c4c);
        break;
      case 3:
        color = Color(0xffff4500);
        break;
      default :
        color = Color(0xffff0000);
        break;
    }
    Paint enemycolor = Paint()..color = color;
    c.drawRect(enemyrect, enemycolor);
  }

  void attack(){
    if(!gameController.player.isdead){
      gameController.player.currenthealth -= damage;
    }
  }

  void ontapdown(){
    if(!isdead)
      {
        health--;
        if(health<= 0){
          isdead = true;
          gameController.score++;
          if(gameController.score > (gameController.storage.getInt('highscore') ?? 0)){
            gameController.storage.setInt('highscore', gameController.score);
          }
        }
      }
  }
}