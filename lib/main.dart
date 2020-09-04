import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_controller.dart';
import 'package:flutter/widgets.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Util flameutil = Util();
  await flameutil.fullScreen();
  await flameutil.setOrientation(DeviceOrientation.portraitUp);

  SharedPreferences storage = await SharedPreferences.getInstance();
  GameController gameController = GameController(storage);
  runApp(gameController.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = gameController.ontapdown;
  // ignore: deprecated_member_use
  flameutil.addGestureRecognizer(tapper);

}