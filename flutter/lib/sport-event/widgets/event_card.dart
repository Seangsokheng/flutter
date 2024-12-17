import 'package:flutter/material.dart';
import '../models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(event.name),
        subtitle: Text('${event.date} at ${event.time}'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/details',
            arguments: event,
          );
        },
      ),
    );
  }
}
