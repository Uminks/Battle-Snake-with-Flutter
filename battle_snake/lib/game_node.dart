part of game;

final double _gameSizeWidth = 320.0;
double _gameSizeHeight = 320.0;

class GameDemoNode extends NodeWithSize {

  Node _gameScreen;
  VirtualJoystick _joystick;

  GameDemoNode(): super(new Size(320.0, 320.0)) {

    _gameScreen = new Node();
    addChild(_gameScreen);

    _joystick = new VirtualJoystick();
    _joystick.scale = 0.40;

   // _joystick.position = new Offset(150.0, -350.0);
    _gameScreen.addChild(_joystick);

  }

  void update(double n){

    print(_joystick.value);

  }

  

  void spriteBoxPerformedLayout() {
    _gameSizeHeight = spriteBox.visibleArea.height;
    _gameScreen.position = new Offset(0.0, _gameSizeHeight);
  }

}

