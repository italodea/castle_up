// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:castle_up/widgets/tower_button.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key, required this.towerA, required this.towerB});
  final int towerA;
  final int towerB;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late Timer _timer;

  final player = AudioPlayer();

  int _start = 0;
  int _end = 3;

  void startTimer() {
    setState(() {
      _start = 0;
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if(_start == 0){
          player.play(AssetSource('caduceus.mp3'));
        }else if(_start == _end){
          player.stop();
          player.dispose();
        }
        if (_start == _end) {
          setState(() {
            timer.cancel();
          });
          showFinalDialog();
        } else {
          setState(() {
            _start++;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void showFinalDialog() {
    String winner = widget.towerA > widget.towerB
        ? "Torre A"
        : widget.towerB > widget.towerA
            ? "Torre B"
            : "Empate";
    int points = widget.towerA > widget.towerB
        ? widget.towerA
        : widget.towerB > widget.towerA
            ? widget.towerB
            : widget.towerA;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Jogo encerrado",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "O resultado final foi $winner com $points pontos.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TowerButton(
                    addToBody: () {
                      Navigator.pop(context);
                    },
                    label: "Fechar",
                  )
                ],
              ),
            ),
          );
        });
  }

  Color getBackgroundColorTimer() {
    if (_start < 10) {
      return Colors.black;
    }
    if (_start == _end) {
      return Color.fromARGB(255, 5, 29, 9);
    }

    if (_start % 2 == 0) {
      return Colors.red.shade600;
    }
    return Colors.red.shade800;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
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
                'Torre A: ${widget.towerA}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: getBackgroundColorTimer(),
                ),
                child: Center(
                  child: Text(
                    '$_start',
                    style: TextStyle(
                      fontSize: 30,
                      color: _start == _end ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                'Torre B: ${widget.towerB}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_start == 0 || _start == _end)
              TowerButton(
                  label: "Iniciar",
                  addToBody: () {
                    startTimer();
                  })
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
