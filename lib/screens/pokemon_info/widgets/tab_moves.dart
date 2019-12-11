import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/screens/move/move_page.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

class PokemonMoves extends StatelessWidget {
  final Pokemon pokemon;

  PokemonMoves(this.pokemon);

  List<Widget> _buildMoveList(BuildContext context) {
    List<Widget> moveList = [];
    pokemon.moves.forEach((move) {
      moveList.add(ListTile(
        title: Text(capitalizeFirstChar(move.name)),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MovePage(move))),
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
        children: _buildMoveList(context),
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
