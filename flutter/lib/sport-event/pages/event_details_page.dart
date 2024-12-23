import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week3/sport-event/widgets/detailCard.dart';
import 'package:week3/sport-event/widgets/detailRow.dart';
import '../models/event.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;

  const EventDetailsPage({required this.event, super.key});

  Widget _buildImage(Event event) {
    Widget imageWidget;
    if (event.imageBytes != null) {
      imageWidget = Image.memory(event.imageBytes!,
          width: double.infinity, height: 300, fit: BoxFit.cover);
    } else if (event.imagePath.startsWith('/images')) {
      imageWidget = Image.asset(event.imagePath,
          width: double.infinity, height: 300, fit: BoxFit.cover);
    } else if (event.imagePath.isNotEmpty) {
      imageWidget = Image.file(File(event.imagePath),
          width: double.infinity, height: 300, fit: BoxFit.cover);
    } else {
      imageWidget = Container(
        height: 300,
        color: Colors.grey[300],
        child: const Icon(Icons.event, size: 80, color: Colors.grey),
      );
    }

    return Stack(
      children: [
        imageWidget,
        Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMMMd();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  _buildImage(event),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildDetailCard(
                      context,
                      [
                        buildDetailRow(
                          event.category.icon,
                          'Category',
                          event.category.label,
                          Colors.deepOrange,
                        ),
                        const SizedBox(height: 16),
                        buildDetailRow(
                          Icons.calendar_today,
                          'Date',
                          formatter.format(event.date),
                          Colors.deepOrange,
                        ),
                        const SizedBox(height: 16),
                        buildDetailRow(
                          Icons.access_time,
                          'Time',
                          event.time,
                          Colors.deepOrange,
                        ),
                        const SizedBox(height: 16),
                        buildDetailRow(
                          Icons.price_change,
                          'Price',
                          event.price,
                          Colors.deepOrange,
                        ),
                        const SizedBox(height: 16),
                        buildDetailRow(
                          Icons.location_on,
                          'Location',
                          event.location,
                          Colors.deepOrange,
                        ),
                        const SizedBox(height: 16),
                        buildDetailRow(
                          Icons.description,
                          'Description',
                          event.description,
                          Colors.deepOrange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}