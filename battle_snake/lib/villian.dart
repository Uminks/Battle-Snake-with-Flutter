part of game;

class Villian extends Node {

  ImageMap _imageMap;
  Sprite _sprite;
  double _dx, _dy;

  double get dx => _dx;
  double get dy => _dy;

  Villian(this._imageMap){
   _sprite = Sprite.fromImage(_imageMap['assets/EnergyFinal.gif']);
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

 }

}