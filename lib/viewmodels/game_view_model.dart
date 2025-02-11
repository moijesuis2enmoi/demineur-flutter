import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/case_model.dart';
import '../models/map_model.dart';

class GameViewModel extends ChangeNotifier {
  late MapModel _map;
  bool lost = false;
  bool won = false;

  get map => _map;

  void click(int row, int col) {
    if (lost || won) {
      return;
    }

    CaseModel? c = _map.tryGetCase(row, col);
    if (c == null) {
      return;
    }
    if (c.hasFlag) {
      return;
    }
    if (c.hasBomb) {
      c.hasExploded = true;
      _map.revealAll();
      lost = true;
      notifyListeners();
      return;
    }

    if (c.number == 0) {
      _map.revealAdjacents(row, col);
    } else {
      _map.reveal(c);
    }
    notifyListeners();
  }

  void onLongPress(CaseModel c) {
    if (lost || won) {
      return;
    }
    if (c.hidden) {
      c.hasFlag = !c.hasFlag;
      if (c.hasFlag) {
        _map.nbFlag++;
      } else if (!c.hasFlag) {
        _map.nbFlag--;
      }
      notifyListeners();
    }
  }

  void generateMap(int nbLine, int nbCol, int nbBomb) {
    _map = MapModel(nbLine: nbLine, nbCol: nbCol, nbBomb: nbBomb);
    _map.generateMap();
  }

  bool isLost() {
    return lost;
  }

  bool isWon() {
    if (lost) {
      return false;
    }
    for (var c in _map.cases.expand((e) => e)) {
      if (c.hidden && !c.hasBomb) {
        return false;
      }
    }
    return true;
  }

Widget getIcon(CaseModel c) {
 if (c.hasFlag) {
   return const Icon(FontAwesomeIcons.flag, size: 20);
 }
  if (c.hasExploded) {
    return const Icon(FontAwesomeIcons.fire, size: 20);
  }
  if (!c.hidden && c.hasBomb) {
    return Icon(FontAwesomeIcons.bomb, size: 20);
  }

  if (c.hidden) {
    return const SizedBox();
  }

  switch (c.number) {
    case 1:
      return Text('1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    case 2:
      return Text('2', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    case 3:
      return Text('3', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    case 4:
      return Text('4', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    case 5:
      return Text('5', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    case 6:
      return Text('6', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    case 7:
      return Text('7', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    case 8:
      return Text('8', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    default:
      return const SizedBox();
  }
}
}