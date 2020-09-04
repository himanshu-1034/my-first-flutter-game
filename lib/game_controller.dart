import 'package:first_flutter_game/components/enemy.dart';
import 'package:first_flutter_game/components/healthbar.dart';
import 'package:first_flutter_game/components/highscoretext.dart';
import 'package:first_flutter_game/components/scoretext.dart';
import 'package:first_flutter_game/components/startbutton.dart';
import 'package:first_flutter_game/enemyspawner.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/player.dart';
import 'dart:math';
import 'package:first_flutter_game/state.dart';
import 'components/enemy.dart';
import 'dart:ui';
class GameController extends Game{
  final SharedPreferences storage;
  Random rand;
  Enemyspawner enemyspawner;
  Size screensize;
  double tilesize;
  Player player;
  List<Enemy> enemies;
  Healthbar healthbar;
  int score;
  Scoretext scoretext;
  Statee state;
  Highscoretext highscoretext;
  Startbutton startbutton;
    GameController(this.storage){
      initialize();
    }

      void initialize() async{
          resize(await Flame.util.initialDimensions());
          state = Statee.menu;
          rand = Random();
          player = Player(this);
          enemies = List<Enemy>();
          enemyspawner = Enemyspawner(this);
          healthbar = Healthbar(this);

          score = 0;
          scoretext = Scoretext(this);
          highscoretext = Highscoretext(this);
          startbutton = Startbutton(this);

      }
    void render(Canvas c){
      Rect background  = Rect.fromLTWH(0, 0, screensize.width, screensize.height);
      Paint backgroundpaint = Paint()..color = Color(0xfffafafa);
      c.drawRect(background, backgroundpaint);


      player.render(c);

      if(state == Statee.menu){
          startbutton.render(c);
        highscoretext.render(c);
      }
      else if(state == Statee.playing)
        {
          enemies.forEach((Enemy enemy) => enemy.render(c));
          scoretext.render(c);
          healthbar.render(c);
        }
    }

    void update(double t){
      if(state==Statee.menu){
          startbutton.update(t);
        highscoretext.update(t);
      }
      else if(state == Statee.playing){
        enemyspawner.update(t);
        enemies.forEach((Enemy enemy) => enemy.update(t));
        enemies.removeWhere((Enemy enemy) => enemy.isdead);
        player.update(t);
        scoretext.update(t);
        healthbar.update(t);
      }

    }

    void resize(Size size){
      screensize = size;
      tilesize = screensize.width / 10;
    }

    void ontapdown(TapDownDetails d) {
      if (state == Statee.menu) {
        state = Statee.playing;
      }
      else if (state == Statee.playing) {
        enemies.forEach((Enemy enemy) {
          if (enemy.enemyrect.contains(d.globalPosition)) {
            enemy.ontapdown();
          }
        });
      }
    }


    void spawnenemy(){
      double x,y;
      switch(rand.nextInt(4)){
        case 0:
          //top
          x=rand.nextDouble()*screensize.width;
          y= -tilesize *2.5;
          break;
        case 1:
          //right
          x=screensize.width + tilesize*2.5;
          y=rand.nextDouble()*screensize.height;
          break;
        case 2:
          //bottom
          x = rand.nextDouble()*screensize.width;
          y= screensize.height + tilesize*2.5;
          break;
        case 3:
          //left
          x = -tilesize*2.5;
          y=rand.nextDouble() * screensize.height;
          break;

      }
      enemies.add(Enemy(this,x,y));
    }
}