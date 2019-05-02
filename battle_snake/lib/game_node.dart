part of game;

final double _gameSizeWidth = 320.0;
double _gameSizeHeight = 320.0;

class GameDemoNode extends NodeWithSize {

  GameDemoNode(): super(new Size(320.0, 320.0)) {

    _gameScreen = new Node();
    addChild(_gameScreen);


    _joystick = new VirtualJoystick();
    _gameScreen.addChild(_joystick);

  }

  Node _gameScreen;
  VirtualJoystick _joystick;

  void spriteBoxPerformedLayout() {
    _gameSizeHeight = spriteBox.visibleArea.height;
    _gameScreen.position = new Offset(0.0, _gameSizeHeight);
  }

}

