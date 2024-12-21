import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week3/sport-event/data/event_data.dart';
import '../models/event.dart';
import '../models/sport_category.dart';
import 'create_event_page.dart';
import 'event_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Mode { create, edit }

class _HomePageState extends State<HomePage> {
  SportsCategory? _selectedCategory;

  Future<void> _addEvent(BuildContext context, Mode mode, Event? event) async {
    final Event? result = await Navigator.push<Event>(
      context,
      MaterialPageRoute(
        builder: (context) => CreateEventPage(
          mode: mode,
          initialItem: event,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        if (mode == Mode.create) {
          Events.add(result);
        } else {
          final index = Events.indexOf(event!);
          if (index != -1) {
            Events[index] = result;
          }
        }
      });
    }
  }

  void _toggleJoin(Event event) {
    setState(() {
      event.toggleJoin();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            event.isJoined ? 'Joined event!' : 'Removed from joined events'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _deleteEvent(Event event, int index) {
    setState(() {
      Events.remove(event);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Event deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              Events.insert(index, event);
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  List<Event> get _filteredEvents {
    if (_selectedCategory == null) return Events;
    return Events.where((event) => event.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOCAL EVENTS',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "What's Up",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_outline),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Category Pills
            SizedBox(
              height: 90,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryPill(
                    icon: Icons.apps,
                    label: 'All',
                    isSelected: _selectedCategory == null,
                    onTap: () => setState(() => _selectedCategory = null),
                  ),
                  ...SportsCategory.values.map((category) => CategoryPill(
                        icon: category.icon,
                        label: category.label,
                        isSelected: _selectedCategory == category,
                        onTap: () =>
                            setState(() => _selectedCategory = category),
                      )),
                ],
              ),
            ),

            // Events List
            Expanded(
              child: _filteredEvents.isEmpty
                  ? const Center(
                      child: Text(
                        'No events added yet.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredEvents.length,
                      itemBuilder: (context, index) => EventCard(
                        event: _filteredEvents[index],
                        onEdit: () => _addEvent(
                            context, Mode.edit, _filteredEvents[index]),
                        onDelete: () =>
                            _deleteEvent(_filteredEvents[index], index),
                        onJoinToggle: () => _toggleJoin(_filteredEvents[index]),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addEvent(context, Mode.create, null),
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CategoryPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryPill({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isSelected ? Colors.deepOrange : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    } else if (kIsWeb && event.imagePath.isNotEmpty) {
      return Image.network(event.imagePath, fit: BoxFit.cover);
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
              Container(
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
              Positioned(
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
              ),
              Positioned(
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
                        Row(
                          children: [
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert,
                                  color: Colors.white),
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
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(event.category.icon,
                            color: Colors.white, size: 16),
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
