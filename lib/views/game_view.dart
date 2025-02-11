import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_arguments.dart';
import '../viewmodels/game_view_model.dart';
import '../widgets/map_button.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  bool _isMapGenerated = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isMapGenerated) {
      final args = ModalRoute.of(context)?.settings.arguments as GameArguments?;
      if (args != null) {
        final gameViewModel = context.read<GameViewModel>();
        gameViewModel.generateMap(args.nbLine, args.nbCol, args.nbBomb);
        _isMapGenerated = true;
      } else {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as GameArguments?;
    final gameViewModel = context.watch<GameViewModel>();
    if (gameViewModel.isWon()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/won');
      });
    } else if (gameViewModel.isLost()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/lost');
      });
    }

    if (args == null) {
      return Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error: No arguments provided"),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () => (Navigator.pushNamed(context, '/')),
                child: Text("Back Home"),
              ),
            ),
          ],
        )),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Text("Mode: ${args.difficulty.toUpperCase()}"),
                Text("Bombs: ${gameViewModel.map.nbBomb - gameViewModel.map.nbFlag}"),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: args.nbCol * 25,
                height: args.nbLine * 25,
                child: Table(
                  border: TableBorder.all(),
                  defaultColumnWidth: const FixedColumnWidth(25.0),
                  children: List.generate(
                    args.nbLine,
                    (i) => TableRow(
                        children: List.generate(
                            args.nbCol,
                            (j) => SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: MapButton(row: i, col: j),
                                )
                        )
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => (Navigator.pushNamed(context, '/')),
                  child: Text("Back"),
                ),
                ElevatedButton(
                  onPressed: () =>
                      (Navigator.pushNamed(context, '/game', arguments: args)),
                  child: Text("Restart"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
