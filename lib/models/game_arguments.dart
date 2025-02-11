class GameArguments {
  final String difficulty;
  final int nbLine;
  final int nbCol;
  final int nbBomb;

  GameArguments(this.difficulty)
      : nbLine = _getNbLine(difficulty),
        nbCol = _getNbCol(difficulty),
        nbBomb = _getNbBomb(difficulty);

  static int _getNbLine(String difficulty) {
    if (difficulty == "easy") {
      return 10;
    } else if (difficulty == "medium") {
      return 18;
    } else if (difficulty == "hard") {
      return 24;
    } else {
      return 10;
    }
  }

  static int _getNbCol(String difficulty) {
    if (difficulty == "easy") {
      return 8;
    } else if (difficulty == "medium") {
      return 14;
    } else if (difficulty == "hard") {
      return 20;
    } else {
      return 8;
    }
  }

  static int _getNbBomb(String difficulty) {
    if (difficulty == "easy") {
      return 10;
    } else if (difficulty == "medium") {
      return 40;
    } else if (difficulty == "hard") {
      return 99;
    } else {
      return 10;
    }
  }
}
