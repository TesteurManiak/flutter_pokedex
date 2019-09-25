import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/configs/AppColors.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/capitalizeFirst.dart';
import 'package:pokedex/widgets/progress.dart';
import 'package:provider/provider.dart';

class StatWidget extends StatelessWidget {
  const StatWidget({
    Key key,
    @required this.label,
    @required this.value,
    @required this.progress,
  }) : super(key: key);

  final String label;
  final double progress;
  final String value;

  @override
  Widget build(BuildContext context) {
    final Animation animation = Provider.of<Animation>(context);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(color: AppColors.black.withOpacity(0.6)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text("$value"),
        ),
        Expanded(
          flex: 5,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, widget) => ProgressBar(
              progress: animation.value * progress,
              color: progress < 0.5 ? AppColors.red : AppColors.teal,
            ),
          ),
        ),
      ],
    );
  }
}

class PokemonBaseStats extends StatefulWidget {
  const PokemonBaseStats({Key key, @required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  _PokemonBaseStatsState createState() => _PokemonBaseStatsState();
}

class _PokemonBaseStatsState extends State<PokemonBaseStats>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  List<StatWidget> _stats = [];

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  _buildStats() {
    widget.pokemon.stats.forEach((stat) {
      _stats.add(StatWidget(
        label: capitalizeFirst(stat.name),
        value: stat.baseStat.toString(),
        progress: stat.baseStat / 100,
      ));
    });
    Iterable inReverse = _stats.reversed;
    _stats = inReverse.toList();
  }

  @override
  void initState() {
    super.initState();

    _buildStats();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    CurvedAnimation curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _controller,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<Animation>(
      builder: (context) => _animation,
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ..._stats.expand((stat) => [stat, SizedBox(height: 14)]),
            SizedBox(height: 27),
            Text(
              "Type defenses",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 0.8,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "The effectiveness of each type on Charmander.",
              style: TextStyle(color: AppColors.black.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }
}
