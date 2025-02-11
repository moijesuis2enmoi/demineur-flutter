import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/case_model.dart';
import '../models/map_model.dart';

class GameViewModel extends ChangeNotifier {
  final _map = MapModel(nbLine: 10, nbCol: 10, nbBomb: 10);

  void generateMap() {
    _map.generateMap();
    notifyListeners();
  }

  void click(CaseModel c) {
    if (c.hasFlag) {
      return;
    }
    if (c.hasBomb) {
      c.hasExploded = true;
      _map.revealAll();
      notifyListeners();
      return;
    }
    _map.reveal(c);
    notifyListeners();
  }

  void onLongPress(CaseModel c) {
    if (c.hidden) {
      c.hasFlag = !c.hasFlag;
      notifyListeners();
    }
  }

Widget getIcon(CaseModel c) {
 if (c.hasFlag) {
   return const Icon(FontAwesomeIcons.flag, size: 40);
 }
  if (c.hasExploded) {
    return const Icon(FontAwesomeIcons.fire, size: 40);
  }
  if (!c.hidden && c.hasBomb) {
    return Icon(FontAwesomeIcons.bomb, size: 40);
  }
  switch (c.number) {
    case 0:
      return Text('0', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
    case 1:
      return Text('1', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
    case 2:
      return Text('2', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
    case 3:
      return Text('3', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
    case 4:
      return Text('4', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
    case 5:
      return Text('5', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
    case 6:
      return Text('6', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
    case 7:
      return Text('7', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
    case 8:
      return Text('8', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
    default:
      return const SizedBox();
  }
}
}