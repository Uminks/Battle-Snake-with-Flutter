part of game;

double _gameSizeWidth = 450.0;
double _gameSizeHeight = 225.0;

class GameNode extends NodeWithSize {

  final GameState _gameState;
  Node _gameScreen;
  VirtualJoystick _joystick;
  Snake _snake;
  ImageMap _imageMap;
  GradientNode _background;

  GameNode(this._gameState, this._imageMap): super(new Size(_gameSizeWidth,_gameSizeHeight)) {

    _background = new GradientNode(
      this.size,
      Color.fromRGBO(0, 0, 70, 1),
      Color.fromRGBO(28, 181, 224, 1),
    );
    addChild(_background);

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
    _snake.detectCollision();
  }

  void spriteBoxPerformedLayout() {
    _gameSizeHeight = spriteBox.visibleArea.height;
    _gameScreen.position = new Offset(0.0, _gameSizeHeight);
  }

}



class GradientNode extends NodeWithSize {
  GradientNode(Size size, this.colorTop, this.colorBottom) : super(size);

  Color colorTop;
  Color colorBottom;

  @override
  void paint(Canvas canvas) {
    applyTransformForPivot(canvas);

    Rect rect = Offset.zero & size;
    Paint gradientPaint = new Paint()..shader = new LinearGradient(
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.topRight,
        colors: <Color>[colorTop, colorBottom],
        stops: <double>[0.0, 1.0]
    ).createShader(rect);

    canvas.drawRect(rect, gradientPaint);
  }
}



