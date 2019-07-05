import 'dart:ui';

import 'package:meta/meta.dart';

class PlayerControl {
  double posX;
  double posY;
  double radius;
  Paint paint;

  PlayerControl(
      {@required this.posX, @required this.posY, @required this.radius}) {
    paint = Paint();
    paint.color = Color(0xFF000000);
  }

  draw(Canvas canvas) {
    canvas.drawCircle(Offset(posX, posY), radius-20, paint);
  }

  move(Offset offset, double width) {

    if (!checkCanMove(offset)) {
      return;
    }

    if (offset.dx < radius) {
      posX = radius;
      return;
    }

    if (offset.dx > width - radius) {
      posX = width - radius;
      return;
    }

    posX = offset.dx;
  }

  checkCanMove(Offset offset) {
    if (offset.dx > posX - radius + 10 &&
        offset.dx < posX + radius - 10 &&
        offset.dy > posY - radius + 10 &&
        offset.dy < posY + radius - 10) {
      return true;
    } else {
      return false;
    }
  }
}
