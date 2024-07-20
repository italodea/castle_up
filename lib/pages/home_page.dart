// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

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

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
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
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Torre A: $towerA'),
                    Text('Torre B: $towerB'),
                  ],
                ),
              ),
              Expanded(
                flex: 18,
                child: Focus(
                  focusNode: _focusNode,
                  onKeyEvent: _handleKeyEvent,
                  child: ListenableBuilder(
                    listenable: _focusNode,
                    builder: (context, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            ],
          ),
        ],
      ),
    );
  }
}
