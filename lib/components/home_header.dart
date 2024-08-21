// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:castle_up/widgets/tower_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader(
      {super.key,
      required this.towerA,
      required this.towerB,
      required this.onStart,
      required this.onEnd,
      required this.resetValues});
  final int towerA;
  final int towerB;

  final void Function() onStart;
  final void Function() onEnd;
  final void Function() resetValues;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late Timer _timer;

  final player = AudioPlayer();

  int _start = 0;
  final int _end = 24;

  void startTimer() {
    setState(() {
      _start = 0;
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          widget.onStart();
          player.play(AssetSource('caduceus.mp3'));
        } else if (_start == _end) {
          player.stop();
        }
        if (_start == _end) {
          setState(() {
            timer.cancel();
            widget.onEnd();
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
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
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
                  Text("Obrigado por jogar nosso joguinho. Jogo feito para a disciplina de Fundamentos de Jogos Digitais."),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Desenvolvido por: Gabriel Cavalcante e Ítalo de Azevedo"),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      launchUrl(
                        Uri.parse(
                          'https://www.youtube.com/@thejoe1469/videos',
                        ),
                      );
                    },
                    child: Text(
                      'Music by CaduceusJ.',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TowerButton(
                    addToBody: () {
                      Navigator.pop(context);
                      _start = 0;
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
    if (_start < 20) {
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
          height: 74,
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Torre A: ${widget.towerA}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Column(
                    children: [
                      Container(
                        height: 70,
                        width: 50,
                        decoration: BoxDecoration(
                          color: getBackgroundColorTimer(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                '$_start',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: _start == _end
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Torre B: ${widget.towerB}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_start == 0)
          TowerButton(
              label: "Iniciar",
              addToBody: () {
                startTimer();
              }),
        if (_start == _end)
          TowerButton(
              label: "Reiniciar",
              addToBody: () {
                widget.resetValues();
              }),
      ],
    );
  }
}
