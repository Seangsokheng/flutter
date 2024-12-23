import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week3/sport-event/models/event.dart';
import 'package:week3/sport-event/pages/event_details_page.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onJoinToggle;

  const EventCard({
    super.key,
    required this.event,
    required this.onEdit,
    required this.onDelete,
    this.onJoinToggle,
  });

  Widget _buildImage(Event event) {
    if (event.imageBytes != null) {
      return Image.memory(event.imageBytes!, fit: BoxFit.cover);
    } else if (event.imagePath.startsWith('/images')) {
      return Image.asset(event.imagePath, fit: BoxFit.cover);
    } else if (!kIsWeb && event.imagePath.isNotEmpty) {
      return Image.file(File(event.imagePath), fit: BoxFit.cover);
    } else {
      return Container(
        color: Colors.grey.shade200,
        child: const Icon(Icons.event, size: 50, color: Colors.grey),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(event: event),
          ),
        );
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildImage(event),
              _buildGradientOverlay(),
              _buildJoinButton(),
              _buildEventDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
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
    );
  }

  Widget _buildJoinButton() {
    return Positioned(
      top: 16,
      right: 16,
      child: ElevatedButton.icon(
        onPressed: onJoinToggle,
        icon: Icon(
          event.isJoined ? Icons.check : Icons.add,
          color: event.isJoined ? Colors.white : Colors.deepOrange,
          size: 18,
        ),
        label: Text(
          event.isJoined ? 'Joined' : 'Join',
          style: TextStyle(
            color: event.isJoined ? Colors.white : Colors.deepOrange,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: event.isJoined ? Colors.deepOrange : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildEventDetails() {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  event.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildPopupMenu(),
            ],
          ),
          const SizedBox(height: 8),
          _buildEventInfo(),
        ],
      ),
    );
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      onSelected: (String choice) {
        if (choice == 'Edit') {
          onEdit();
        } else if (choice == 'Delete') {
          onDelete();
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 'Edit',
          child: Text('Edit'),
        ),
        const PopupMenuItem(
          value: 'Delete',
          child: Text('Delete'),
        ),
      ],
    );
  }

  Widget _buildEventInfo() {
    return Row(
      children: [
        Icon(event.category.icon, color: Colors.white, size: 16),
        const SizedBox(width: 8),
        Text(
          event.location,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Text(
          DateFormat.yMMMMd().format(event.date),
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}