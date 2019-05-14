part of game;

class Laser extends Node{
  Snake snake;
  Sprite _sprite;
  ImageMap _imageMap;
  double dx, dy;
  double dirx , diry, hyp;

  Laser(this.snake, this._imageMap, Offset joystickValue){

    _sprite = Sprite.fromImage(_imageMap['assets/Shot.png']);
    
    _sprite.scale = 0.085;
    _sprite.rotation = snake._sprite.rotation;
    
    double posx = snake.position.dx + ( joystickValue.dx * 3);
    double posy = snake.position.dy + (joystickValue.dy * 3);
    position = new Offset( posx , posy );
    hyp = sqrt( pow( posx , 2 ) + pow( posy , 2 ) );
    dirx = posx / hyp;
    diry = posy / hyp;

    dx = snake._dx;
    dy = snake._dy;

    addChild(_sprite);
  }

  void move(){
    
   
    Offset oldPos = position;
    Offset target = new Offset(oldPos.dx + (dirx*3), oldPos.dy + (diry*3));





    double filterFactor = 2.5;
    position = new Offset(
        GameMath.filter(oldPos.dx, target.dx, filterFactor),
        GameMath.filter(oldPos.dy, target.dy, filterFactor)
    );
  }

  bool isAllowed(){
    if(this.position.dx <= 0 || this.position.dy >= 0 || this.position.dx >= 450 || this.position.dy <= -240)
      return true;

    return false;
  }
}