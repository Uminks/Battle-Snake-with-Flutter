part of game;

class Villian extends Node {

  ImageMap _imageMap;
  Sprite _sprite;
  double _dx, _dy;

  double get dx => _dx;
  double get dy => _dy;

  Villian(this._imageMap){
   _sprite = Sprite.fromImage(_imageMap['assets/Icon.png']);
   _sprite.scale = 0.06;
   _sprite.rotation = 90.0;

    Random random;
    double minx = 0, maxx = 0, miny = 0, maxy = 0;

    // int x = random.nextInt(4);

        minx = -5;
        maxx = -1;
        miny = -220;
        maxy = -1;
    
    /* switch (x) {
      case 0:  //  IZQUIERDA

        break;
      case 1: // DERECHA
        minx = 451;
        maxx = 456;
        miny = -220;
        maxy = -1;        
        break;
      case 2: // ARRIBA
        minx = 1; 
        maxx = 450;
        miny = -225;
        maxy = -230;      
        break;
      case 3: // ABAJO
        minx = 1;
        maxx = 450;
        miny = 1;
        maxy = 5;      
        break;
      default:
    } */
 

   addChild(_sprite);
   position = new Offset( 
                          minx,
                          miny
                        );
   _dx = 0;
   _dy = 1;
 }


 void moveVillian(Snake snake){

    Offset oldPos = position;
    Offset target;

    double dirx = snake.dx - position.dx;
    double diry = snake.dy - position.dy;
    double hyp = sqrt( pow(dirx,2) + pow(diry,2) );

    dirx /= hyp;
    diry /= hyp;

    target = new Offset( dirx, diry);

    double filterFactor = 0.2;

     position = new Offset(
         GameMath.filter(oldPos.dx, target.dx, filterFactor),
         GameMath.filter(oldPos.dy, target.dy, filterFactor)
     );


 }

}