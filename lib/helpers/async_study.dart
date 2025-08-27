import 'dart:math';

import 'package:flutter/material.dart';

asyncStudy() {
  execucaoNormal();
  assincronismoBasico();
  usandoFuncoesAssincronas();
  esperandoFuncoesAssincronas();
}

void execucaoNormal() {
  debugPrint("\nExecução Normal");
  debugPrint("01");
  debugPrint("02");
  debugPrint("03");
  debugPrint("04");
  debugPrint("05");
}

void assincronismoBasico() {
  debugPrint("\nAssincronismo Básico");
  debugPrint("01");
  debugPrint("02");
  Future.delayed(Duration(seconds: 2), () {
    debugPrint("03");
  });
  debugPrint("04");
  debugPrint("05");
}

void usandoFuncoesAssincronas() {
  debugPrint("\nUsando funções assíncronas");
  debugPrint("A");
  debugPrint("B");
  //debugPrint(getRandomInt(3)); // Instance of Future<int>
  getRandomInt(3).then((value) {
    debugPrint("O número aleatório é $value.");
    // E se eu quiser que as coisas só aconteçam depois?
  });
  debugPrint("C");
  debugPrint("D");
}

void esperandoFuncoesAssincronas() async {
  debugPrint("A");
  debugPrint("B");
  int number = await getRandomInt(4);
  debugPrint("O outro número aleatório é $number.");
  debugPrint("C");
  debugPrint("D");
}

Future<int> getRandomInt(int time) async {
  await Future.delayed(Duration(seconds: time));

  Random rng = Random();

  return rng.nextInt(10);
}
