import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.towerA, required this.towerB});
  final int towerA;
  final int towerB;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 40, 33, 243),
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 29, 242, 61),
              width: 4,
            ),
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Torre A: $towerA',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              'Torre B: $towerB',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
