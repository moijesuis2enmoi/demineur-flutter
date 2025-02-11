import 'package:demineur/viewmodels/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapButton extends StatelessWidget {
  final int row;
  final int col;

  MapButton({super.key, required this.row, required this.col});

  @override
  Widget build(BuildContext context) {
    final gameViewModel = context.watch<GameViewModel>();

    return Consumer<GameViewModel>(
      builder: (context, model, child) {
        final c = gameViewModel.map.tryGetCase(row, col);
        return GestureDetector(
          onTap: () => model.click(row, col),
          onLongPress: () => model.onLongPress(c),
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: c.hidden ? Colors.green : Colors.white,
            ),
            child: Center(child: model.getIcon(c)),
          ),
        );
      },
    );
  }
}