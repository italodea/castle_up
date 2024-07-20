import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TowerButton extends StatelessWidget {
  const TowerButton({super.key, required this.pressKey, required this.addToBody});

  final LogicalKeyboardKey pressKey;

  final void Function() addToBody;

  bool isDesktop(){
    try {
      return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => addToBody(),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Text(
          isDesktop() ? "Pressione ${pressKey.keyLabel}" : "Clique",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
