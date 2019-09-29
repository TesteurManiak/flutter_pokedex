import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/data/pokemons.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/screens/pokedex/widgets/generation_modal.dart';
import 'package:pokedex/screens/pokedex/widgets/search_modal.dart';
import 'package:pokedex/screens/pokemon_info/pokemon_info.dart';
import 'package:pokedex/utils/fetch_data.dart';
import 'package:pokedex/widgets/fab.dart';
import 'package:pokedex/widgets/poke_container.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

class Pokedex extends StatefulWidget {
  @override
  _PokedexState createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  bool isLoading = false;

  ScrollController controller;

  _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      startLoader();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _controller);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  _refreshPage() {
    setState(() {});
  }

  void _showSearchModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SearchBottomModal(_refreshPage),
    );
  }

  void _showGenerationModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GenerationModal(),
    );
  }

  Widget _buildLoadedPkmn() {
    searchResult = pokemons;
    if (searchText.isNotEmpty) {
      List<Pokemon> tmpList = [];
      for (int i = 0; i < searchResult.length; i++) {
        if (searchResult[i]
            .name
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          tmpList.add(searchResult[i]);
        }
      }
      searchResult = tmpList;
    }

    return GridView.builder(
      controller: controller,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: EdgeInsets.only(left: 28, right: 28, bottom: 58),
      itemCount: searchResult.length,
      itemBuilder: (context, index) {
        return PokemonCard(
          searchResult[index],
          index: searchResult[index].id,
          onPress: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      PokemonInfo(searchResult[index]))),
        );
      },
    );
  }

  Widget _loader() {
    return isLoading
        ? Align(
            child: Container(
              width: 70.0,
              height: 70.0,
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(child: CircularProgressIndicator())),
            ),
            alignment: FractionalOffset.bottomCenter,
          )
        : SizedBox(
            width: 0.0,
            height: 0.0,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PokeContainer(
            appBar: true,
            children: <Widget>[
              SizedBox(height: 34),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Text(
                  "Pokedex",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Expanded(
                child: _buildLoadedPkmn(),
              ),
            ],
          ),
          _loader(),
          AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return IgnorePointer(
                ignoring: _animation.value == 0,
                child: InkWell(
                  onTap: () {
                    _controller.reverse();
                  },
                  child: Container(
                    color: Colors.black.withOpacity(_animation.value * 0.5),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: ExpandedAnimationFab(
        items: [
          FabItem(
            "Favourite Pokemon",
            Icons.favorite,
            onPress: () {
              _controller.reverse();
            },
          ),
          FabItem(
            "All Type",
            Icons.filter_vintage,
            onPress: () {
              _controller.reverse();
            },
          ),
          FabItem(
            "All Gen",
            Icons.flash_on,
            onPress: () {
              _controller.reverse();
              _showGenerationModal();
            },
          ),
          FabItem(
            "Search",
            Icons.search,
            onPress: () {
              _controller.reverse();
              _showSearchModal();
            },
          ),
        ],
        animation: _animation,
        onPress: () {
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
      ),
    );
  }

  void startLoader() {
    setState(() {
      isLoading = !isLoading;
      fetchData();
    });
  }

  void fetchData() async {
    PokeAPI().fetchNext(8).then((_) {
      setState(() {
        isLoading = !isLoading;
      });
    });
  }
}
