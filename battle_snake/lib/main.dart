
import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:spritewidget/spritewidget.dart';


import 'libraries.dart';

GameState _gameState;
BuildContext device;

final Color _darkTextColor = new Color(0xff3c3f4a);
typedef void SelectTabCallback(int index);
SpriteSheet _spriteSheetUI;

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
    'assets/Shot.png',
    'assets/EnergyFinal.gif',
    'assets/game_ui.png'
  ]);
  String json = await _bundle.loadString('assets/game_ui.json');
  _spriteSheetUI = new SpriteSheet(_imageMap['assets/game_ui.png'], json);

  _gameState = new GameState();
  runApp(new Game());
}

class Game extends StatefulWidget {
  GameDemoState createState() => new GameDemoState();
}

class GameDemoState extends State<Game>{
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  GlobalKey<NavigatorState> _navigatorKey = new GlobalKey<NavigatorState>();

  Future<bool> didPopRoute() async {
    bool result = true;
//    Navigator.openTransaction((NavigatorTransaction transaction) {
//      result = transaction.pop();
//    });
    return result;
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Title(
          title: 'Space Blast',
          color: const Color(0xFF9900FF),
          child: new Navigator(
              key: _navigatorKey,
              onGenerateRoute: (RouteSettings settings) {
                switch (settings.name) {
                  case '/game': return _buildGameSceneRoute();
                  default: return _buildMainSceneRoute();
                }
              }
          )
      ),
    );
  }

  PageRoute _buildGameSceneRoute() {
    return new MaterialPageRoute(builder: (BuildContext context) {
      return new GameScene(
          onGameOver: (int lastScore, int levelReached) {
            setState(() {
              _gameState.lastScore = lastScore;
              _gameState.reachedLevel = levelReached;
            });
          },
          gameState: _gameState
      );
    });
  }

  PageRoute _buildMainSceneRoute() {
    return new MaterialPageRoute(builder: (BuildContext context) {
      return new MainScene(gameState: _gameState);
    });
  }
}

class GameScene extends StatefulWidget {
  final GameState gameState;
  final GameOverCallback onGameOver;

  GameScene({this.gameState, this.onGameOver});
  State<GameScene> createState() => new GameSceneState();
}

class GameSceneState extends State<GameScene> {
  NodeWithSize _game;

  void initState() {
    super.initState();
    _game = new GameNode(
        widget.gameState,
        _spriteSheetUI,
        _imageMap,
        (int score, int levelReached) {
          Navigator.pop(context);
          widget.onGameOver(score, levelReached);
        }
    );
  }
  

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft
    ]);
    return new SpriteWidget(_game, SpriteBoxTransformMode.stretch);
  }
}

class MainScene extends StatefulWidget {
  MainScene({
    this.gameState,
  });

  final GameState gameState;

  State<MainScene> createState() => new MainSceneState();
}

class MainSceneState extends State<MainScene> {

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft
    ]);
    return new CoordinateSystem(
        systemSize: new Size(450.0, 240.0),
        child:new DefaultTextStyle(
            style: new TextStyle(fontFamily: "Mias", fontSize:15.0),


            child: new Container(

              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/mainBackground.png"),
                  fit: BoxFit.cover,
                ),
              ),

            child: new Stack(
                
                children: <Widget>[
                  
                  new Column(
                      
                      children: <Widget>[

                        new SizedBox(
                            width: 450.0,
                            height: 50.0,
                        ),

                        new SizedBox(
                            width: 320.0,
                            height: 50.0,
                            child: new BottomBar(
                                onPlay: () {
                                  Navigator.pushNamed(context, '/game');
                                }
                            )
                        ),

                        new SizedBox(
                            width: 320.0,
                            height: 93.0,
                            child: new BottomBar2(
                              onPlay: (){
                                Navigator.pushNamed(context, '/game');
                              },
                            ),
                        )
                      ]
                  )
                ]
            )


            ),


        )
    );
  }
}

class TopBar extends StatelessWidget {
  TopBar({this.selection, this.onSelectTab, this.gameState});

  final int selection;
  final SelectTabCallback onSelectTab;
  final GameState gameState;

  Widget build(BuildContext context) {

    return new Stack(
        children: <Widget>[
          new Positioned(
              left: 18.0,
              top: 13.0,
              child: new Text(
                  "This is my topBar",
                  style: new TextStyle(
                    fontFamily: "Mias"
                  ),
              )
          ),
        ]
    );
  }
}

class BottomBar extends StatelessWidget {
  BottomBar({this.onPlay, this.onSelectTab, this.gameState});

  final VoidCallback onPlay;
  final SelectTabCallback onSelectTab;
  final GameState gameState;

  Widget build(BuildContext context) {

    return new Stack(
        children: <Widget>[
          new Positioned(
              left: 120.0,
              top: 0.0,
              child: new TextureButton(
                  onPressed: onPlay,
                  label: "PLAY",
                  textAlign: TextAlign.center,
                  width: 181.0,
                  height: 60.0,
                  textStyle: new TextStyle(
                    fontFamily: "Mias",
                    fontSize: 24.0
                  ),
              )
          ),
        ]
    );
  }
}

class BottomBar2 extends StatelessWidget {
  BottomBar2({this.onPlay, this.onSelectTab, this.gameState});

  final VoidCallback onPlay;
  final SelectTabCallback onSelectTab;
  final GameState gameState;

  Widget build(BuildContext context) {

    return new Stack(
        children: <Widget>[
          new Positioned(
              left: 120.0,
              top: 5.0,
              child: new TextureButton(
                  onPressed: onPlay,
                  label: "SCORE",
                  textAlign: TextAlign.center,
                  width: 181.0,
                  height: 60.0,
                  textStyle: new TextStyle(
                    fontFamily: "Mias",
                    fontSize: 24.0
                  ),
              )
          ),
        ]
    );
  }
}



