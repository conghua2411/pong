import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pong/game.dart';

class PongScreen extends StatefulWidget {

//  var game;
  var dimention;
  bool hasPlayer = false;

  PongScreen({this.dimention, this.hasPlayer}) {

//    game = PGame(dimention: dimention);
//
//    HorizontalDragGestureRecognizer horizontalDragGestureRecognizer =
//    HorizontalDragGestureRecognizer();
//
//    Flame.util.addGestureRecognizer(horizontalDragGestureRecognizer
//      ..onUpdate = (startDetails) => game.tapMove(startDetails.globalPosition));
  }

  @override
  State createState() => PongGameState();
}

class PongGameState extends State<PongScreen> {

  var game;
  var dimention;

  @override
  void initState() {
    super.initState();
    game = PGame(dimention: widget.dimention, hasPlayer: widget.hasPlayer, callback: () {

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
    });

    HorizontalDragGestureRecognizer horizontalDragGestureRecognizer =
    HorizontalDragGestureRecognizer();

    Flame.util.addGestureRecognizer(horizontalDragGestureRecognizer
      ..onUpdate = (startDetails) => game.tapMove(startDetails.globalPosition));
  }

  @override
  Widget build(BuildContext context) {
    return game.widget;
  }
}

class PGame extends BaseGame {

  var game;
  var dimention;
  bool hasPlayer = false;

  Function() callback;

  PGame({this.dimention, this.hasPlayer, this.callback}) {
    game = PongGame(dimention: dimention, hasPlayer: hasPlayer);
  }
  
  @override
  void render(Canvas canvas) {
    game.draw(canvas);
  }

  @override
  void update(double t) {
    if (game.gameOn) {
      game.move();
    } else {
      if (dimention != null) {
        game.gameOn = true;

        game.dimention = dimention;
      }
    }

    if (game.gameOver) {
      callback();
    }

  }

  void tapMove(Offset offset) {
    game.update(offset);
  }
}