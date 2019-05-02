import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:spritewidget/spritewidget.dart';

import 'libraries.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('MAIN');
  SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);
  runApp(new GameDemo());
}


class GameDemo extends StatefulWidget {
  GameDemoState createState() => new GameDemoState();
}

class GameDemoState extends State<GameDemo>{

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new GameScene();
  }
}


class GameScene extends StatefulWidget {
  State<GameScene> createState() => new GameSceneState();
}

class GameSceneState extends State<GameScene> {
  NodeWithSize _game;

  void initState() {
    super.initState();
    _game = new GameDemoNode();
  }

  Widget build(BuildContext context) {
    return new SpriteWidget(_game, SpriteBoxTransformMode.fixedWidth);
  }
}



