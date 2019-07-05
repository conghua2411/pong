import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:pong/pong.dart';

void main() async {
  var dimention = await Flame.util.initialDimensions();

  runApp(MaterialApp(
    home: MyApp(dimention: dimention),
  ));
}

class MyApp extends StatefulWidget {
  var dimention;

  MyApp({this.dimention});

  @override
  State createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arcade game'),
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, position) {
            return gameItem();
          }),
    );
  }

  Widget gameItem() {
    return FlatButton(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Pong game',
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ))),
        ),
        onPressed: showDialogPongGame);
  }

  showDialogPongGame() {
    print('asdasdasdasd');
    Dialog pongDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'game mode',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue,
                    child: Text('player vs bot'),
                    onPressed: () {
                      Navigator.pop(context);
                      gotoPong(true);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.red,
                    splashColor: Color.fromARGB(90, 255, 0, 0),
                    child: Text('bot vs bot'),
                    onPressed: () {
                      Navigator.pop(context);
                      gotoPong(false);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );

    showDialog(context: context, builder: (BuildContext context) => pongDialog);
  }

  gotoPong(bool hasPlayer) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PongScreen(
                  dimention: widget.dimention,
                  hasPlayer: hasPlayer,
                )));
  }
}
