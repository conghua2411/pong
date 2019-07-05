import 'package:pong/ball.dart';
import 'package:pong/player.dart';

class DumbBot {
  choseMoveDir(Ball ball, Player player, double width) {

    if (checkSafe(ball, player)) {
      return 0;
    }

    if (player.posX + player.width / 2 < ball.posX) {
      // move right
      return 1;
    }
    if (player.posX + player.width / 2 > ball.posX) {
      // move left
      return -1;
    }

    return 0;
  }

  bool checkSafe(Ball ball, Player player) {
    if (ball.posX >= player.posX && ball.posX <= player.posX + player.width) {
      return true;
    }
    return false;
  }
}