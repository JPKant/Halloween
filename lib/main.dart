import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whack a Pumpkin',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Halloween'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? countdownTimer;
  Duration timerDuration = Duration(seconds: 20);
  bool gameOver = false;
  int count = 0;
  bool isVisible = true;

  int _c = 0;
  List<bool> visible = [
    true,
    false,
    false,
    false,
    true,
    false,
    false,
    false,
    false,
    true,
    false,
    true,
    false,
    false,
    false,
    false
  ];

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = timerDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        stopTimer();
      } else {
        timerDuration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState((() => countdownTimer!.cancel()));
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final secondsLeft = strDigits(timerDuration.inSeconds.remainder(60));
    if (count == 0) {
      startTimer();
    }

    if (int.parse(secondsLeft) <= 0) {
      isVisible = false;
    }

    count++;
    return Scaffold(
        appBar: AppBar(
          title: Text("Score: $_c Time Left: $secondsLeft"),
        ),
        backgroundColor: Colors.black,
        body: Center(
            child: Table(children: <TableRow>[
          TableRow(children: [
            Visibility(visible: isVisible, child: buildTile(0)),
            Visibility(visible: isVisible, child: buildTile(1)),
            Visibility(visible: isVisible, child: buildTile(2)),
            Visibility(visible: isVisible, child: buildTile(3))
          ]),
          TableRow(children: [
            Visibility(visible: isVisible, child: buildTile(4)),
            Visibility(visible: isVisible, child: buildTile(5)),
            Visibility(visible: isVisible, child: buildTile(6)),
            Visibility(visible: isVisible, child: buildTile(7))
          ]),
          TableRow(children: [
            Visibility(visible: isVisible, child: buildTile(8)),
            Visibility(visible: isVisible, child: buildTile(9)),
            Visibility(visible: isVisible, child: buildTile(10)),
            Visibility(visible: isVisible, child: buildTile(11))
          ]),
          TableRow(children: [
            Visibility(visible: isVisible, child: buildTile(12)),
            Visibility(visible: isVisible, child: buildTile(13)),
            Visibility(visible: isVisible, child: buildTile(14)),
            Visibility(visible: isVisible, child: buildTile(15))
          ])
        ])));
  }

  final image = "assets/scary_pumpkin.jpg";

  Widget buildTile(int i) {
    return GestureDetector(
        onTap: () {
          click(i);
        },
        child: Card(
            child: Visibility(
                visible: visible[i],
                child: SizedBox(child: Image(image: AssetImage(image))))));
  }

  void click(int i) {
    setState(() {
      if (visible[i]) {
        _c++;
        for (int i = 0; i < 16; i++) {
          int r = 1 + Random().nextInt(2);
          if (i % r == 0) {
            visible[i] = !visible[i];
          }
        }
        visible[i] = false;
      }
    });
  }
}
