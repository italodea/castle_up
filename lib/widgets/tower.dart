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
      required this.builder});

  final MyBuilder builder;
  final LogicalKeyboardKey pressKey;
  Function increaseNumber;

  @override
  State<Tower> createState() => _TowerState();
}

class _TowerState extends State<Tower> {
  addToBody({bool buttonClick = false}) {
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

  @override
  Widget build(BuildContext context) {
    widget.builder(context, addToBody);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
    );
  }
}
