part of game;

class Snake extends Node{
 ImageMap _imageMap;
 Sprite _sprite;

 Snake(this._imageMap){
   _sprite = Sprite.fromImage(_imageMap['assets/Icon.png']);
   _sprite.scale = 0.06;
   _sprite.rotation = 90.0;

   addChild(_sprite);
   position = new Offset(160.0, -160.0);
   print('${_sprite}');
 }

 void moveSnake(Offset joystickValue){
   Offset oldPos = position;
   Offset target = new Offset(oldPos.dx + (joystickValue.dx*5),oldPos.dy + (joystickValue.dy*5));
   double filterFactor = 0.2;

   _sprite.rotation = atan2(joystickValue.dy,joystickValue.dx)*(180/3.14);

   print(joystickValue.dy);

   position = new Offset(
       GameMath.filter(oldPos.dx, target.dx, filterFactor),
       GameMath.filter(oldPos.dy, target.dy, filterFactor)
   );
 }

}