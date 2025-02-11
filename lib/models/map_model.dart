import 'dart:math';

import 'case_model.dart';

class MapModel {
  int nbLine = 0;
  int nbCol = 0;
  int nbBomb = 0;
  List<List<CaseModel>> _cases = List<List<CaseModel>>.empty();

  MapModel({required int nbLine, required int nbCol, required int nbBomb}) {
    this.nbLine = nbLine;
    this.nbCol = nbCol;
    this.nbBomb = nbBomb;
  }

  bool hiddenn(int row, int col) => _cases[row][col].hidden;
  bool hasFlag(int row, int col) => _cases[row][col].hasFlag;
  bool hasExploded(int row, int col) => _cases[row][col].hasExploded;
  bool hasBomb(int row, int col) => _cases[row][col].hasBomb;


  void _initCases() {
    _cases = List.generate(nbLine, (i) => List.generate(nbCol, (j) => CaseModel()));
  }

  void _initBombs() {
    int bombsPlaced = 0;
    Random random = Random();
    while (bombsPlaced < nbBomb) {
      int row = random.nextInt(nbLine);
      int col = random.nextInt(nbCol);
      if (!_cases[row][col].hasBomb) {
        _cases[row][col].hasBomb = true;
        bombsPlaced++;
      }
    }
  }

  int _computeNumber(int row, int col) {
    int count = 0;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (i == 0 && j == 0) continue;
        CaseModel? neighbor = tryGetCase(row + i, col + j);
        if (neighbor != null && neighbor.hasBomb) {
          count++;
        }
      }
    }
    return count;
  }

  void _initNumbers(){
    for (int i = 0; i < nbLine; i++) {
      for (int j = 0; j < nbCol; j++) {
        if (!_cases[i][j].hasBomb) {
          _cases[i][j].number = _computeNumber(i, j);
        }
      }
    }
  }

  CaseModel? tryGetCase(int row, int col) {
    if (row < 0 || row >= nbLine || col < 0 || col >= nbCol) {
      return null;
    }
    return _cases[row][col];
  }

  void generateMap() {
    _initCases();
    _initBombs();
    _initNumbers();
  }

  void reveal(CaseModel c){
    c.hidden = false;
  }

  void explode(CaseModel c){
    c.hasExploded = true;
  }

  void revealAll(){
    for (var c in _cases.expand((e) => e)) {
      c.hidden = false;
    }
  }

  void toggleFlag(CaseModel c){
    c.hasFlag = !c.hasFlag;
  }
}