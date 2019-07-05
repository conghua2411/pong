import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:pong/ball.dart';
import 'package:pong/bot.dart';
import 'package:pong/player.dart';
import 'package:pong/playerControl.dart';

class PongGame {
  static const double POS1_TOP = 40.0;
  static const double POS2_TOP = 540.0;

//  double moveStep = 10;
//  double moveStepBald = 5.5;
  double moveStep = 20;
  double moveStepBald = 5.5;

  var dimention;

  Player player1, player2;

  Ball ball;

  DumbBot dumbBot;

  bool gameOn = false;

  PlayerControl playerControl;

  int score1, score2;

  bool gameOver = false;

  bool hasPlayer = false;

  PongGame({this.dimention, this.hasPlayer}) {
    playerControl =
        PlayerControl(posX: 50.0, posY: POS2_TOP + 50, radius: 50.0);
    player1 = Player(posX: 0.0, posY: POS1_TOP, width: 100.0, height: 10.0);
    player2 = Player(posX: 0.0, posY: POS2_TOP, width: 100.0, height: 10.0);

    ball =
        Ball(posX: 10.0, posY: (POS1_TOP + POS2_TOP) / 2, speed: moveStepBald);

    dumbBot = DumbBot();

    score1 = 0;
    score2 = 0;
  }

  draw(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(0.0, 0.0, dimention.width, dimention.height),
        Paint()..color = Color(0xFFFFFFFF));

    player1.draw(canvas);
    player2.draw(canvas);

    ball.draw(canvas);

    if (hasPlayer) {
      playerControl.draw(canvas);
    }

    drawScore(canvas);
  }

  move() {
    if (ball.checkWin != 0) {
      resetGame(ball.checkWin);
    }

    // player 1 bot
    if (ball.dirY < 0 && ball.posY >= player1.posY + player1.height) {
      switch (dumbBot.choseMoveDir(ball, player1, dimention.width)) {
        case 1:
          if (player1.posX + player1.width < dimention.width) {
            player1.move(moveStep.abs());
          }
          break;
        case -1:
          if (player1.posX > 0) {
            player1.move(-moveStep.abs());
          }
          break;
        default:
          break;
      }
    }

    if (!hasPlayer) {
      // player 2 bot
      if (ball.dirY > 0 && ball.posY <= player2.posY) {
        switch (dumbBot.choseMoveDir(ball, player2, dimention.width)) {
          case 1:
            if (player2.posX + player2.width < dimention.width) {
              player2.move(moveStep.abs());
            }
            break;
          case -1:
            if (player2.posX > 0) {
              player2.move(-moveStep.abs());
            }
            break;
          default:
            break;
        }
      }
    } else {
      if (player2Move != 0) {
        if (player2Move == 1 && player2.posX + 100.0 < dimention.width) {
          player2.move(moveStep);
        }

        if (player2Move == -1 && player2.posX > 0) {
          player2.move(moveStep);
        }
      }
    }

    ball.move(player1, player2, dimention.width);
  }

  update(Offset offset) {
    if (hasPlayer) {
      playerControl.move(offset, dimention.width);
      player2.goto(playerControl.posX - 50.0);
    }
  }

  int player2Move = 0;

  void resetGame(int whoWin) {
    if (whoWin == 1) {
      score1++;
    } else {
      score2++;
    }

    if (score1 == 10 || score2 == 10) {
//      gameOver = true;
    }

    ball = Ball(
        posX: randomPos(dimention.width),
        posY: (POS1_TOP + POS2_TOP) / 2,
        speed: moveStepBald);
  }

  double randomPos(double width) {
    Random rand = Random();

    return Ball.BALD_RADIUS +
        rand.nextDouble() * (dimention.width - 2 * Ball.BALD_RADIUS);
  }

  void drawScore(Canvas canvas) {
    String text = score1.toString(); // text to render
    ParagraphBuilder paragraph = new ParagraphBuilder(new ParagraphStyle());
    paragraph
        .pushStyle(new TextStyle(color: new Color(0xFF000000), fontSize: 48.0));
    paragraph.addText(text);
    var p = paragraph.build()..layout(new ParagraphConstraints(width: 180.0));
    canvas.drawParagraph(p, new Offset(10.0, (POS1_TOP + POS2_TOP) / 2 - 20));

    String text2 = score2.toString(); // text to render
    ParagraphBuilder paragraph2 = new ParagraphBuilder(new ParagraphStyle());
    paragraph2
        .pushStyle(new TextStyle(color: new Color(0xFF000000), fontSize: 48.0));
    paragraph2.addText(text2);
    var p2 = paragraph2.build()..layout(new ParagraphConstraints(width: 180.0));
    canvas.drawParagraph(p2, new Offset(10.0, (POS1_TOP + POS2_TOP) / 2 + 20));
  }
}
