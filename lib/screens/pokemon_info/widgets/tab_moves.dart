import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:provider/provider.dart';

class PokemonMoves extends StatelessWidget {
  final Pokemon pokemon;

  PokemonMoves(this.pokemon);

  List<Widget> _buildMoveList() {
    List<Widget> moveList = [];
    pokemon.moves.forEach((move) {
      moveList.add(ListTile(
        title: Text(move.name),
      ));
    });
    return moveList;
  }

  @override
  Widget build(BuildContext context) {
    final cardController = Provider.of<AnimationController>(context);

    if (pokemon.moves == null) {
      return Center(
        child: SizedBox(
          height: 28,
          width: 28,
          child: CircularProgressIndicator(),
        ),
      );
    }

    return AnimatedBuilder(
      animation: cardController,
      child: Column(
        children: _buildMoveList(),
      ),
      builder: (BuildContext context, Widget child) {
        final scrollable = cardController.value.floor() == 1;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 19, horizontal: 27),
          physics: scrollable
              ? BouncingScrollPhysics()
              : NeverScrollableScrollPhysics(),
          child: child,
        );
      },
    );
  }
}
