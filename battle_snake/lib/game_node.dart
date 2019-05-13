part of game;


double _gameSizeWidth = 450.0;
double _gameSizeHeight = 240.0;

class GameNode extends NodeWithSize {

  final GameState _gameState;
  Node _gameScreen;
  VirtualJoystick _joystick;
  Snake _snake;
  ImageMap _imageMap;
  List<Villian> enemy = <Villian>[];
  GradientNode _background;
  List<Laser> lasers = <Laser>[];

  GameNode(this._gameState, this._imageMap): super(new Size(_gameSizeWidth,_gameSizeHeight)) { // Node Constructor

    userInteractionEnabled = true; // Activating user interaction
    handleMultiplePointers = true; // Multiple pointers

    addObjects(); // Adding game objects

  }

  @override
  bool handleEvent(SpriteBoxEvent event) { // Events
    if (event.type == PointerDownEvent)
      fire();

    return true;
  }

  void addObjects(){ // Adding initial objects

    _background = new GradientNode(
      this.size,
      Color.fromRGBO(0, 0, 70, 1),
      Color.fromRGBO(28, 181, 224, 1),
    );
    super.addChild(_background);


    _gameScreen = new Node();
    super.addChild(_gameScreen);


    _joystick = new VirtualJoystick();
    _joystick.scale = 0.50;
    _joystick.position = new Offset(50.0,-10.0);

    _snake = new Snake(_imageMap);

    _gameScreen.addChild(_joystick);
    _gameScreen.addChild(_snake);

    addEnemy();
    addEnemy();


  }

  void fire(){
      Laser shot = new Laser(_snake, _imageMap, _joystick.value);
      lasers.add(shot);
      _gameScreen.addChild(shot);
  }

  void addEnemy(){
       Villian e = new Villian(_imageMap);
       enemy.add(e);
      _gameScreen.addChild(e);
  }

  void update(double n){ // Updating game state
    _snake.moveSnake(_joystick.value);

    for (Laser shoot in lasers)
       shoot.move();

    _snake.detectCollision();

    enemy.forEach((e) => e.moveVillian(_snake));
    
  }

  void spriteBoxPerformedLayout() { // Rendering Node object
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



