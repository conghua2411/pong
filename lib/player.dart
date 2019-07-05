import 'dart:ui';

import 'package:meta/meta.dart';

class Player {

  double posX;
  double posY;
  double width;
  double height;

  Paint paint;

  Player({
    @required this.posX,
    @required this.posY,
    @required this.width,
    @required this.height}) {
    paint = Paint();
    paint.color = Color(0xFFFF0000);
  }

  draw(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(posX, posY, width, height), paint);
  }

  move(double X) {
    posX += X;
  }

  goto(double X) {
    posX = X;
  }

}