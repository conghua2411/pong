import 'dart:math';
import 'dart:ui';

import 'package:meta/meta.dart';
import 'package:pong/player.dart';

//enum Direction {
//  TopLeft,
//  TopRight,
//  BottomLeft,
//  BottomRight,
//}

class Ball {
  static const BALD_RADIUS = 10.0;

  double posX, posY;
  Paint paint, paintListBall;

//  Direction dir;
  double speed;
  int checkWin;

  // new dir
  int dirX, dirY;
  double dirSpeedX, dirSpeedY;

  List<double> listBallX, listBallY;
  int maxList;

  Ball({@required this.posX, @required this.posY, @required this.speed}) {
    paint = Paint();
    paintListBall = Paint();

    paint.color = Color(0xFFFFFF00);
    paintListBall.color = Color(0x10000000);

    listBallX = List();
    listBallY = List();

    maxList = 50;

    checkWin = 0;

    createDirSpeed();
    randomDir();
  }

  void createDirSpeed() {
    Random rand = Random();

    dirSpeedX = rand.nextDouble() * speed;

    dirSpeedY = sqrt(pow(speed, 2) - pow(dirSpeedX, 2));

    print('hello : $dirSpeedX --- $dirSpeedY --- speed : $speed');
  }

  void randomDir() {
    Random rand = Random();

    dirX = rand.nextBool() ? 1 : -1;
    dirY = rand.nextBool() ? 1 : -1;
  }

  draw(Canvas canvas) {
    for (int i = 0; i < listBallX.length; i++) {
      canvas.drawCircle(Offset(listBallX[i], listBallY[i]),
          BALD_RADIUS / 2 + i / 8, paintListBall);
    }
    canvas.drawCircle(Offset(posX, posY), BALD_RADIUS, paint);
  }

  move(Player player1, Player player2, double width) {
    checkBound(player1, player2, width);

    listBallX.add(posX);
    listBallY.add(posY);

    if (listBallX.length > maxList) {
      listBallX.removeAt(0);
      listBallY.removeAt(0);
    }

    posX += dirSpeedX * dirX;
    posY += dirSpeedY * dirY;
  }

  checkBound(Player player1, Player player2, double width) {
    // check win lose

    // check boundary
    if (posX + BALD_RADIUS + dirSpeedX * dirX >= width) {
      // right
      dirX = -dirX;
    }

    if (posX - BALD_RADIUS + dirSpeedX * dirX <= 0) {
      // left
      dirX = -dirX;
    }

    if ((posY < player1.posY && dirY < 0) ||
        (posY > player2.posY + player2.height && dirY > 0)) {

      if (dirSpeedX > 1) {
        dirSpeedX /= 100;
        dirSpeedY /= 100;
      }

      maxList = 100;
    }

    if (posY < player1.posY - 20) {
      checkWin = -1;

      listBallX.clear();
      listBallY.clear();
      return;
    }

    if (posY > player2.posY + player2.height + 20) {
      checkWin = 1;

      listBallX.clear();
      listBallY.clear();
      return;
    }

    if (posY - BALD_RADIUS + dirSpeedY * dirY <=
            player1.posY + player1.height &&
        posY >= player1.posY + player1.height &&
        posX >= player1.posX &&
        posX <= player1.posX + player1.width &&
        dirY < 0) {
      if (speed < 150) {
        speed += 0.5;
      }
      // top

      dirY = -dirY;
      createDirSpeed();
    }

    if (posY + BALD_RADIUS + dirSpeedY * dirY >= player2.posY &&
        posY <= player2.posY &&
        posX >= player2.posX &&
        posX <= player2.posX + player2.width &&
        dirY > 0) {
      if (speed < 150) {
        speed += 0.5;
      }
      // bottom

      dirY = -dirY;
      createDirSpeed();
    }
  }
}
