part of game;


double _gameSizeWidth = 450.0;
double _gameSizeHeight = 240.0;

typedef void GameOverCallback(int score, int levelReached);

class GameNode extends NodeWithSize {

  final GameState _gameState;
  Node _gameScreen;
  VirtualJoystick _joystick;
  Snake _snake;
  ImageMap _imageMap;
  List<Villian> enemies = <Villian>[];
  GradientNode _background;
  Laser shot;
  int level, xenemy;
  SpriteSheet _spritesUI;
  PlayerState _playerState;
  GameOverCallback _gameOverCallback;
  Label showLevel, label;


  GameNode(
      this._gameState,
      this._spritesUI,
      this._imageMap,
      this._gameOverCallback
  ): super(new Size(_gameSizeWidth,_gameSizeHeight)) { // Node Constructor

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

    _playerState = new PlayerState(_spritesUI, _gameState);

    _joystick = new VirtualJoystick();
    _joystick.scale = 0.50;
    _joystick.position = new Offset(50.0,-10.0);

    _snake = new Snake(_imageMap);

    _gameScreen.addChild(_playerState);
    _gameScreen.addChild(_joystick);
    _gameScreen.addChild(_snake);

    level = 1; xenemy = 0;

    
    label = Label(
        'Level: ${level} ',
        textStyle: new TextStyle(
                    fontFamily: "Mias"
                  )
    );
    label.position = new Offset( 180.0, 10);


    addChild(label);
    startTimer();
 

  }

  void startTimer(){

    Timer.periodic(
      new Duration(milliseconds: 1000), 
      (Timer t) {
        addEnemy();
        if(t.tick == level * 4){
          t.cancel();
        } 
      } 
    );

  }

  void fire(){
      if(shot == null){
        shot = new Laser(_snake, _imageMap, _joystick.value);
        _gameScreen.addChild(shot);
      }
  }

  void checkingShoot(){
      if(shot.isAllowed()){
        _gameScreen.removeChild(shot);
        shot = null;
      }
  }

  void addEnemy(){
       Villian e = new Villian(_imageMap);
       enemies.add(e);
      _gameScreen.addChild(e);
  }

  void update(double n){ // Updating game state
    _snake.moveSnake(_joystick.value);

    if(shot != null){
      shot.move();
      checkingShoot();
    }

    if(_snake.detectCollision()){
      _playerState.life -= 10;
    }

    if(_playerState.life <= 0){

      print('END GAME');
      _snake.restartPosition();
      _playerState.life = 100;
      level = 1;
      _gameOverCallback(_playerState.score, level);

    }


    if(_snake.checkEnemyCollision(enemies)){
      _playerState.life -= 0.3;
    }

    for(Villian e in enemies){
        e.moveVillian(_snake);
        if(shot != null){
          if(e.checkShotCollision(shot)) {
            _gameScreen.removeChild(e);
            xenemy += 1;
            enemies.remove(e);
            e.frame = 0;

            _playerState.score += 5;
            _playerState.life += 1;
            break;
          }
        }
    }

    if(xenemy == level*4){
            
      removeChild(label);
      level += 1;
      xenemy = 0;
      label.text = 'Level: ${level} ';
      startTimer();
      _gameScreen.removeChild(shot);
      shot = null;
      _snake.restartPosition();
      addChild(label);
      

      
    }
    
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



