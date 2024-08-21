// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:castle_up/components/home_header.dart';
import 'package:castle_up/widgets/tower.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int towerA = 0;
  int towerB = 0;

  bool pressingS = false;
  bool pressingL = false;

  final FocusNode _focusNode = FocusNode();

  late void Function() increaseA;
  late void Function() increaseB;

  double? sizeWidth;

  String backgroundPlayerA = 'assets/background.png';

  bool gameRunning = false;

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!gameRunning) {
      return KeyEventResult.ignored;
    }

    if (event.logicalKey == LogicalKeyboardKey.keyS &&
        event.character?.toUpperCase() == "S" &&
        !pressingS) {
      setState(() {
        towerA = towerA + 1;
        pressingS = true;
      });
      increaseA.call();
    }
    if (event.logicalKey == LogicalKeyboardKey.keyL &&
        event.character?.toUpperCase() == "L" &&
        !pressingL) {
      setState(() {
        towerB = towerB + 1;
        pressingL = true;
      });
      increaseB.call();
    }
    if (event.logicalKey == LogicalKeyboardKey.keyS &&
        event.character == null) {
      setState(() {
        pressingS = false;
      });
    }
    if (event.logicalKey == LogicalKeyboardKey.keyL &&
        event.character == null) {
      setState(() {
        pressingL = false;
      });
    }
    return KeyEventResult.ignored;
  }

  @override
  void initState() {
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            flex: 18,
            child: Focus(
              focusNode: _focusNode,
              onKeyEvent: _handleKeyEvent,
              child: ListenableBuilder(
                listenable: _focusNode,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Tower(
                        builder:
                            (BuildContext context, void Function() increase) {
                          increaseA = increase;
                        },
                        pressKey: LogicalKeyboardKey.keyS,
                        increaseNumber: () {
                          setState(() {
                            towerA = towerA + 1;
                          });
                        },
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        width: 10,
                        thickness: 10,
                      ),
                      Tower(
                        builder:
                            (BuildContext context, void Function() increase) {
                          increaseB = increase;
                        },
                        pressKey: LogicalKeyboardKey.keyL,
                        increaseNumber: () {
                          setState(() {
                            towerB = towerB + 1;
                          });
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          HomeHeader(
            towerA: towerA,
            towerB: towerB,
            onStart: () {
              setState(() {
                gameRunning = true;
              });
            },
            onEnd: () {
              setState(() {
                gameRunning = false;
              });
            },
            resetValues: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
