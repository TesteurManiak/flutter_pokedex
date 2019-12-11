import 'package:flutter/material.dart';
import 'package:pokedex/models/move.dart';

class MovePage extends StatefulWidget {
  final Move move;

  MovePage(this.move);

  @override
  State<StatefulWidget> createState() => _MovePageState();
}

class _MovePageState extends State<MovePage> {
  bool _isLoading = true;

  _loadMoveInfo() async {}

  @override
  void initState() {
    super.initState();
    _loadMoveInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.move.name),
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[],
                  ),
                ),
              ),
      ),
    );
  }
}
