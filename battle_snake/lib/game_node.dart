part of game;

 final double _gameSizeWidth = 320.0;
double _gameSizeHeight = 320.0;

class GameNode extends NodeWithSize {

  final GameState _gameState;
  Node _gameScreen;
  VirtualJoystick _joystick;
  Snake _snake;
  ImageMap _imageMap;

 
  GameNode(this._gameState, this._imageMap): super(new Size(350.0, 350.0)) {

    _gameScreen = new Node();
    addChild(_gameScreen);

    _joystick = new VirtualJoystick();
    _joystick.scale = 0.50;




    _snake = new Snake(_imageMap);

    _joystick.position = new Offset(50.0,-10.0);
    _gameScreen.addChild(_joystick);
    _gameScreen.addChild(_snake);

  }

  void update(double n){
    _snake.moveSnake(_joystick.value);
    //print(_joystick.value);
  }

  void spriteBoxPerformedLayout() {
    _gameSizeHeight = spriteBox.visibleArea.height;
    _gameScreen.position = new Offset(0.0, _gameSizeHeight);
  }

}


class Level extends Node {
  Snake snake;

  Level() {
    position = new Offset(160.0, 0.0);
  }
}


