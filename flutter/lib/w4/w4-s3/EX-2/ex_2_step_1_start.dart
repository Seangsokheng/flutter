import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Favorite cards"),
        ),
        body: const Column(
          
          children: [
            FavoriteCards(
              isfavorite: true,
            ),
            FavoriteCards(
              isfavorite: false,
            ),
            FavoriteCards(
              isfavorite: true,
            ),
          ],
        ),
      ),
    ));

class FavoriteCards extends StatefulWidget {
  final bool isfavorite;
  const FavoriteCards({
    required this.isfavorite,
    super.key,
  });

  @override
  State<FavoriteCards> createState() => _FavoriteCardsState();
}

class _FavoriteCardsState extends State<FavoriteCards> {
  late bool isFavorite = widget.isfavorite;

  void Selected() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

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
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "title",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w800),
                ),
                Text("description"),
              ],
            ),
          ),
          IconButton(
            onPressed: Selected,
            icon: const Icon(Icons.favorite),
            color: isFavorite ? Colors.red : Colors.grey,
          ),
        ],
      ),
      // YOUR CODE
    );
  }
}
