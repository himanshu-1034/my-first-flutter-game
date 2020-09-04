import 'package:first_flutter_game/components/enemy.dart';
import 'package:first_flutter_game/game_controller.dart';

class Enemyspawner{
  final GameController gameController;
  final int maxspawninterval = 3000;
  final int minspawninterval = 700;
  final int intervalchange = 3;
  final int maxenemies = 7;
  int currentinterval;
  int nextspawn;
  Enemyspawner(this.gameController){
    initialize();
  }


  void initialize(){
    killallenemies();
    currentinterval = maxspawninterval;
    nextspawn = DateTime.now().millisecondsSinceEpoch + currentinterval;
  }

  void killallenemies(){
    gameController.enemies.forEach((Enemy enemy) => enemy.isdead=true);
  }
  void update(double t){
    int now= DateTime.now().millisecondsSinceEpoch;
    if(gameController.enemies.length < maxenemies && now >= nextspawn){
      gameController.spawnenemy();
      if(currentinterval > minspawninterval){
        currentinterval -= intervalchange;
        currentinterval -= (currentinterval*0.1).toInt();
      }
      nextspawn = now + currentinterval;
    }
  }
}