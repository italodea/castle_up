// ignore_for_file: must_be_immutable

import 'package:castle_up/widgets/tower_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef MyBuilder = void Function(
    BuildContext context, void Function() increase);

class Tower extends StatefulWidget {
  Tower(
      {super.key,
      required this.increaseNumber,
      required this.pressKey,
      required this.builder, required this.isGameRunning});

  final MyBuilder builder;
  final LogicalKeyboardKey pressKey;
  final bool isGameRunning;
  Function increaseNumber;

  @override
  State<Tower> createState() => _TowerState();
}

class _TowerState extends State<Tower> {
  addToBody({bool buttonClick = false}) {
    if(!widget.isGameRunning){
      return;
    }
    if (buttonClick) {
      widget.increaseNumber();
    }
    if (listTower.length < MediaQuery.of(context).size.height / 85) {
      setState(() {
        listTower.add(Image.asset(
          'assets/body.png',
          width: 92,
          fit: BoxFit.fitWidth,
        ));
      });
    } else if (backgroundIndex < 16) {
      setState(() {
        backgroundIndex += 1;
      });
      listTower.removeRange(1, listTower.length);
    }
  }

  List<Widget> listTower = [
    Image.asset(
      'assets/topo.png',
      width: 92,
      fit: BoxFit.fitWidth,
    ),
    Image.asset(
      'assets/body.png',
      width: 92,
      fit: BoxFit.fitWidth,
    ),
  ];

  List<String> backgroundImage = [
    'assets/background.png',
    'assets/background_2.png',
    'assets/background_3.png',
    'assets/background_4.png',
    'assets/background_5.png',
    'assets/background_6.png',
    'assets/background_7.png',
    'assets/background_8.png',
    'assets/background_9.png',
    'assets/background_10.png',
    'assets/background_11.png',
    'assets/background_12.png',
    'assets/background_13.png',
    'assets/background_14.jpg',
    'assets/background_15.jpg',
    'assets/background_16.png',
    'assets/background_17.jpg',
  ];
  int backgroundIndex = 0;

  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    widget.builder(context, addToBody);
    return Stack(
      children: [
        Image.asset(
          backgroundImage[backgroundIndex],
          fit: BoxFit.cover,
          height: double.infinity,
          width: (sizeWidth - 10) / 2,
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 140,
              width: (MediaQuery.of(context).size.width - 10) / 2,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () => widget.increaseNumber(),
                child: TowerButton(
                  addToBody: () => addToBody(buttonClick: true),
                  pressKey: widget.pressKey,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 92,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    FittedBox(
                      alignment: AlignmentDirectional.bottomCenter,
                      fit: BoxFit.fitWidth,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: listTower,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
