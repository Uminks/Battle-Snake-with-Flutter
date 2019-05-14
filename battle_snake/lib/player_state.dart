part of game;

class PlayerState extends Node {
  PlayerState(this._sheetUI, this._gameState) {
    // Score display
    _spriteBackgroundScore = new Sprite(_sheetUI["scoreboard.png"]);
    _spriteBackgroundScore.pivot = new Offset(1.0, 0.0);
    _spriteBackgroundScore.scale = 0.22;
    _spriteBackgroundScore.position = new Offset(430.0, -230.0);
    addChild(_spriteBackgroundScore);

    //print('size: ${_spriteBackgroundScore.size}');

    _scoreDisplay = new ScoreDisplay(_sheetUI);
    _scoreDisplay.position = new Offset(349.0, 49.0);
    _spriteBackgroundScore.addChild(_scoreDisplay);


    _spriteBackgroundLife = new Sprite(_sheetUI["bar_shield.png"]);
    _spriteBackgroundLife.pivot = new Offset(1.0, 0.0);
    _spriteBackgroundLife.scale = 0.22;
    _spriteBackgroundLife.position = new Offset(112.0, -230.0);
    addChild(_spriteBackgroundLife);


    _lifeDisplay = new LifeDisplay(_sheetUI);
    _lifeDisplay.position = new Offset(124.0, 49.0);
    _spriteBackgroundLife.addChild(_lifeDisplay);

    // Coin display
    /*_spriteBackgroundCoins = new Sprite(_sheetUI["coinboard.png"]);
    _spriteBackgroundCoins.pivot = new Offset(1.0, 0.0);
    _spriteBackgroundCoins.scale = 0.35;
    _spriteBackgroundCoins.position = new Offset(105.0, 10.0);
    addChild(_spriteBackgroundCoins);

    _coinDisplay = new ScoreDisplay(_sheetUI);
    _coinDisplay.position = new Offset(252.0, 49.0);
    _spriteBackgroundCoins.addChild(_coinDisplay);*/

  }

  final SpriteSheet _sheetUI;
  final GameState _gameState;


  Sprite _spriteBackgroundLife;
  Sprite _spriteBackgroundScore;
  ScoreDisplay _scoreDisplay;
  LifeDisplay _lifeDisplay;

  int get score => _scoreDisplay.score;
  double get life => _lifeDisplay.life;

  set score(int score) {
    _scoreDisplay.score = score;
    flashBackgroundSprite(_spriteBackgroundScore);
  }

  set life(double life) {
    _lifeDisplay.life = life;
    flashBackgroundSprite(_spriteBackgroundLife);
  }

  void flashBackgroundSprite(Sprite sprite) {
    sprite.actions.stopAll();
    ActionTween flash = new ActionTween<Color>(
            (a) { sprite.colorOverlay = a; },
        new Color(0x66ccfff0),
        new Color(0x00ccfff0),
        0.3);
    sprite.actions.run(flash);
  }

}

class ScoreDisplay extends Node {
  ScoreDisplay(this._sheetUI);

  int _score = 0;

  int get score => _score;

  set score(int score) {
    _score = score;
    _dirtyScore = true;
  }

  SpriteSheet _sheetUI;

  bool _dirtyScore = true;

  void update(double dt) {
    if (_dirtyScore) {
      removeAllChildren();

      String scoreStr = _score.toString();
      double xPos = -37.0;
      for (int i = scoreStr.length - 1; i >= 0; i--) {
        String numStr = scoreStr.substring(i, i + 1);
        Sprite numSprite = new Sprite(_sheetUI["number_$numStr.png"]);
        numSprite.position = new Offset(xPos, 0.0);
        addChild(numSprite);
        xPos -= 37.0;
      }
      _dirtyScore = false;
    }
  }
}

class LifeDisplay extends Node {
  LifeDisplay(this._sheetUI);

  double _life = 100;

  double get life => _life;

  set life(double life) {
    _life = life;
    _dirtyLife = true;
  }

  SpriteSheet _sheetUI;

  bool _dirtyLife = true;

  void update(double dt) {
    scaleX = _life/100;
    if (_dirtyLife) {
      removeAllChildren();

      Sprite numSprite = new Sprite(_sheetUI["bar_shield_fill.png"]);
      if(life >= 35) numSprite.position = new Offset(_life, 0.0);
      else if(life >10) numSprite.position = new Offset(_life - 80, 0.0);
      else numSprite.position = new Offset(-280 - (life * 2), 0.0);
      addChild(numSprite);
    }
    _dirtyLife = false;
  }
}





