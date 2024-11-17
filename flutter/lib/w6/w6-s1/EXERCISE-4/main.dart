import 'package:flutter/material.dart';
import 'package:week3/w6/w6-s1/EXERCISE-4/jokes.dart';

Color appColor = Colors.green[300] as Color;

void main() => runApp(MaterialApp(
      home: FavoriteJokes(),
    ));

class FavoriteJokes extends StatefulWidget {
  @override
  _FavoriteJokesState createState() => _FavoriteJokesState();
}

class _FavoriteJokesState extends State<FavoriteJokes> {
  int? _currentFavoriteId; 

  void updateFavorite(int id) {
    setState(() {
      if (_currentFavoriteId == id) {
        _currentFavoriteId = null; 
      } else {
        _currentFavoriteId = id; 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text("Favorite Jokes"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...jokes.map(
              (item) => FavoriteCard(
                id: item.id,
                title: item.title,
                description: item.description,
                isFavorite: _currentFavoriteId == item.id, 
                onFavoriteClick: updateFavorite, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final String title;
  final String description;
  final int id;
  final bool isFavorite;
  final Function(int) onFavoriteClick;

  const FavoriteCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.onFavoriteClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: appColor, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10.0),
                Text(description),
              ],
            ),
          ),
          IconButton(
            onPressed: () => onFavoriteClick(id),
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
