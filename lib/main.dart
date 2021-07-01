import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import './question.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.lightBlue[400],
        scaffoldBackgroundColor: Colors.deepOrange[100],
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Timer? _timer;

  void _modCounter(int value) {
    setState(() => _counter += value);
  }

  void _startTimer() {
    if (_timer == null) {
      _timer = new Timer.periodic(new Duration(milliseconds: 1000), (t) {
        _modCounter(-1);
        if (_counter == 0) {
          _timer!.cancel();
          _timer = null;
          FlutterRingtonePlayer.playNotification();
        }
      });
    }
  }

  void _stopTimer() {}

  @override
  void initState() {
    print("initState");
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lines = [
      ['+10', 10],
      ['+5', 5],
      ['-5', -5],
      ['-10', -10],
    ];
    return Scaffold(
      appBar: AppBar(
          // title: Text(widget.title),

          title: Text(
        'Absolute Total Counter',
        textAlign: TextAlign.center,
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Question(
              'Click to count how many times you have clicked ',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                ElevatedButton(
                    onPressed: () => _modCounter(1), child: Icon(Icons.add)),
                Spacer(),
                Text(
                  '|$_counter|',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Spacer(),
                ElevatedButton(
                    onPressed: () => _modCounter(-1),
                    child: Icon(Icons.remove)),
                Spacer(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    width: 278,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.pink)),
                        onPressed: () => setState(() => _counter = 0),
                        child: Text('Reset')),
                  ),
                )
              ],
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: () => _startTimer(),
                child: Text('* START *')),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () => _stopTimer(),
                child: Text('STOP')),
            ...lines.map((line) => ElevatedButton(
                child: Text((line[0] as String)),
                onPressed: () {
                  _modCounter(line[1] as int);
                }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter = 0),
        tooltip: 'Increment',
        child: Icon(Icons.delete),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
