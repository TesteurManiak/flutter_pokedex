import 'package:flutter/material.dart';
import 'package:pokedex/data/pokemons.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/screens/pokemon_info/widgets/info.dart';
import 'package:pokedex/screens/pokemon_info/widgets/tab.dart';
import 'package:pokedex/widgets/slide_up_panel.dart';
import 'package:provider/provider.dart';

class PokemonInfo extends StatefulWidget {
  final Pokemon pokemon;

  PokemonInfo(this.pokemon);

  @override
  _PokemonInfoState createState() => _PokemonInfoState();
}

class _PokemonInfoState extends State<PokemonInfo>
    with TickerProviderStateMixin {
  static const double _pokemonSlideOverflow = 20;

  GlobalKey _pokemonInfoKey = GlobalKey();

  AnimationController _cardController;
  AnimationController _cardHeightController;

  double _cardMinHeight = 0.0;
  double _cardMaxHeight = 0.0;

  _loadPkmnInfo() async {
    await api.fetchSpecies(widget.pokemon.species);
    await api.fetchGenderRate(widget.pokemon.species);
    await api.fetchEvolutionChain(widget.pokemon.species);
    setState(() {});
  }

  @override
  void initState() {
    _cardController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _cardHeightController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 220));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenHeight = MediaQuery.of(context).size.height;
      final appBarHeight = 60 + 22 + IconTheme.of(context).size;

      final RenderBox pokemonInfoBox =
          _pokemonInfoKey.currentContext.findRenderObject();

      _cardMinHeight =
          screenHeight - pokemonInfoBox.size.height + _pokemonSlideOverflow;
      _cardMaxHeight = screenHeight - appBarHeight;

      _cardHeightController.forward();
    });

    super.initState();

    if (widget.pokemon.species.genus == null ||
        widget.pokemon.species.femaleRate == null) {
      _loadPkmnInfo();
    }
  }

  @override
  void dispose() {
    _cardController.dispose();
    _cardHeightController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      builder: (context) => _cardController,
      child: Scaffold(
        backgroundColor: widget.pokemon.color,
        body: Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: _cardHeightController,
              child: PokemonTabInfo(widget.pokemon),
              builder: (context, child) {
                return SlidingUpPanel(
                  controller: _cardController,
                  minHeight: _cardMinHeight * _cardHeightController.value,
                  maxHeight: _cardMaxHeight,
                  child: child,
                );
              },
            ),
            IntrinsicHeight(
              child: Container(
                key: _pokemonInfoKey,
                child: PokemonOverallInfo(widget.pokemon),
              ),
            )
          ],
        ),
      ),
    );
  }
}
