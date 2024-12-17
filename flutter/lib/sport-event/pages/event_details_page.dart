import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;

  const EventDetailsPage({required this.event, super.key});

  Widget _buildImage(Event event) {
    if (event.imageBytes != null) {
      return Image.memory(event.imageBytes!,
          width: double.infinity, height: 200, fit: BoxFit.cover);
    } else if (event.imagePath.startsWith('/images')) {
      return Image.asset(event.imagePath,
          width: double.infinity, height: 200, fit: BoxFit.cover);
    } else if (event.imagePath.isNotEmpty) {
      return Image.file(File(event.imagePath),
          width: double.infinity, height: 200, fit: BoxFit.cover);
    } else {
      return Container(
        height: 200,
        color: Colors.grey[300],
        child: const Icon(Icons.event, size: 80, color: Colors.grey),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMMMd();
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image Section
            _buildImage(event),

            // Event Details Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Name
                  Text(
                    event.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // Description
                  Row(
                    children: [
                      const Icon(Icons.description, color: Colors.blueAccent),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Category
                  Row(
                    children: [
                      Icon(event.category.icon, color: Colors.orangeAccent),
                      const SizedBox(width: 8),
                      Text(
                        'Category: ${event.category.label}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Date and Time
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        'Date: ${formatter.format(event.date)}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.redAccent),
                      const SizedBox(width: 8),
                      Text(
                        'Time: ${event.time}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.purpleAccent),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Location: ${event.location}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
