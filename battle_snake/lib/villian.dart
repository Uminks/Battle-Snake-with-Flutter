part of game;

class Villian extends Node {

  ImageMap _imageMap;
  Sprite _sprite;
  double _dx, _dy;
  int _index;
  int frame;

  double get dx => _dx;
  double get dy => _dy;
  int get index => _index;

  Villian(this._imageMap){
    frame = 0;
   _sprite = Sprite.fromImage(_imageMap['assets/frame_${frame}.png']);
   _sprite.scale = 0.5;
   _sprite.rotation = 90.0;

    Random random = new Random();
    double minx = 0, maxx = 0, miny = 0, maxy = 0;

    
    int x = random.nextInt(4);
    
    switch (x) {
      case 0:  //  IZQUIERDA

        minx = (random.nextDouble() * 5) + (-5) ;
        miny =  (random.nextDouble() * 220) + (-220);

        break;
      case 1: // DERECHA

        minx = (random.nextDouble() * 5) + (451) ;
        miny =  (random.nextDouble() * 220) + (-220);
 
        break;
      case 2: // ARRIBA

        minx = (random.nextDouble() * 450) + (1) ;
        miny = (random.nextDouble() * -5) + (-230) ;
  
        break;
      case 3: // ABAJO
        
        
        minx = (random.nextDouble() * 450) + (1) ;
        miny = (random.nextDouble() * 5) + (1) ;
  
        break;
      default:
    }
 

   addChild(_sprite);
   position = new Offset( 
      minx ,
      miny
    );
   _dx = 0;
   _dy = 1;
 }


 void moveVillian(Snake snake){

    Offset oldPos = position;
    double filterFactor = 0.01;
     position = new Offset(
         GameMath.filter(oldPos.dx, snake.position.dx, filterFactor),
         GameMath.filter(oldPos.dy, snake.position.dy, filterFactor)
     );

     frame++;
     removeChild(_sprite);
     _sprite = Sprite.fromImage(_imageMap['assets/frame_${frame}.png']);
    _sprite.scale = 0.5;
     addChild(_sprite);
     if(frame == 11){
       frame = 0;
     }

 }

  bool checkShotCollision(Laser shot){

    if(GameMath.distanceBetweenPoints(position, shot.position) <= 8){
      return true;
    }
    return false;
  }

}