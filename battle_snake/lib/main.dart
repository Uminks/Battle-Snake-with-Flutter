
import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:spritewidget/spritewidget.dart';


import 'libraries.dart';

GameState _gameState;
BuildContext device;

AssetBundle _initBundle() {
  if (rootBundle != null)
    return rootBundle;
  return new NetworkAssetBundle(new Uri.directory(Uri.base.origin));
}

final AssetBundle _bundle = _initBundle();

ImageMap _imageMap;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);

  _imageMap = new ImageMap(_bundle);
  await _imageMap.load(<String>[
    'assets/Icon.png',
    'assets/Shot.png'
  ]);

  _gameState = new GameState();
  runApp(new GameScene(gameState: _gameState));
}

class GameScene extends StatefulWidget {
  final GameState gameState;
  GameScene({this.gameState});
  State<GameScene> createState() => new GameSceneState();
}

class GameSceneState extends State<GameScene> {
  NodeWithSize _game;

  void initState() {
    super.initState();
    _game = new GameNode(widget.gameState, _imageMap);
  }
  

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft
    ]);
    return new SpriteWidget(_game, SpriteBoxTransformMode.stretch);
  }
}



