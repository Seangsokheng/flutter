import 'dart:typed_data';

import 'package:week3/sport-event/models/sport_category.dart';

class Event {
  final String id;
  final String name;
  final String description;
  final SportsCategory category;
  final DateTime date;
  final String time;
  final String location;
  String imagePath;
  final Uint8List? imageBytes;
  String price;
  bool isJoined;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.date,
    required this.time,
    required this.location,
    required this.price,
    this.imagePath = '',
    this.imageBytes,
    this.isJoined = false,
  });

  void toggleJoin() {
    isJoined = !isJoined;
  }
}
