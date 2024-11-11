import 'package:flutter/material.dart';

List<String> images = [
  "assets/w4-s2/bird.jpg",
  "assets/w4-s2/bird2.jpg",
  "assets/w4-s2/insect.jpg",
  "assets/w4-s2/girl.jpg",
  "assets/w4-s2/man.jpg",
];

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, // Why this line ? Can you explain it ?
      home: Slideshow(),
    ));

class Slideshow extends StatefulWidget {
  const Slideshow({
    super.key,
  });

  @override
  State<Slideshow> createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  int imageInt = 0;

  void next() {
    setState(() {
      if (imageInt == images.length -1) {
        imageInt = 0;
      } else {
        imageInt++;
      }
    });
  }

  void prev() {
    setState(() {
      if (imageInt == 0) {
        imageInt = images.length -1;
      } else {
        imageInt--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('Image viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_before),
            tooltip: 'Go to the previous image',
            onPressed: prev,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
            child: IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: 'Go to the next image',
              onPressed: next,
            ),
          ),
        ],
      ),
      body: Image.asset(images[imageInt]),
    );
  }
}
