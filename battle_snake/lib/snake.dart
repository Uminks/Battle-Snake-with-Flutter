part of game;

class Snake extends Node{
 ImageMap _imageMap;
 Sprite _sprite;
 double _dx, _dy;

 Snake(this._imageMap){
   _sprite = Sprite.fromImage(_imageMap['assets/Icon.png']);
   _sprite.scale = 0.06;
   _sprite.rotation = 90.0;

   addChild(_sprite);
   position = new Offset(160.0, -160.0);
   _dx = 0;
   _dy = 1;
 }

 void moveSnake(Offset joystickValue){
   Offset oldPos = position;
   Offset target;
   if(joystickValue.dx == 0 && joystickValue.dy == 0) {
     target = new Offset(oldPos.dx + (_dx * 3),oldPos.dy + (_dy * 3));
   }
   else {
     target = new Offset(oldPos.dx + (joystickValue.dx * 5),oldPos.dy + (joystickValue.dy * 5) );
     _sprite.rotation = atan2(joystickValue.dy,joystickValue.dx) * (180 / 3.14);
     _dx = joystickValue.dx; _dy = joystickValue.dy;
   }

     double filterFactor = 0.2;

     position = new Offset(
         GameMath.filter(oldPos.dx, target.dx, filterFactor),
         GameMath.filter(oldPos.dy, target.dy, filterFactor)
     );
 }

}