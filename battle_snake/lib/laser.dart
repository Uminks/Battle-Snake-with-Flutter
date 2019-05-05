part of game;

class Laser extends Node{
  Snake snake;
  Sprite _sprite;
  ImageMap _imageMap;
  double dx, dy;

  Laser(this.snake, this._imageMap, Offset joystickValue){

    _sprite = Sprite.fromImage(_imageMap['assets/Icon.png']);
    _sprite.scale = 0.06;
    _sprite.rotation = snake._sprite.rotation;
    position = new Offset(snake.position.dx + (joystickValue.dx * 10), snake.position.dy + (joystickValue.dy * 10));

    dx = snake._dx;
    dy = snake._dy;

    addChild(_sprite);
  }

  void move(){
    Offset oldPos = position;
    Offset target = new Offset(oldPos.dx + dx, oldPos.dy + dy);


    double filterFactor = 2.5;
    position = new Offset(
        GameMath.filter(oldPos.dx, target.dx, filterFactor),
        GameMath.filter(oldPos.dy, target.dy, filterFactor)
    );
  }
}