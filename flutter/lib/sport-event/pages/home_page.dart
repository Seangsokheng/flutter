import 'dart:io';
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
  SportsCategory? _selectedCategory; // For dropdown filtering

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

  void _deleteEvent(Event event) {
    setState(() {
      Events.remove(event);
    });
  }

  // Filter events by category
  List<Event> get _filteredEvents {
    if (_selectedCategory == null) return Events; // Show all events if no filter
    return Events.where((event) => event.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text(
        'No events added yet.',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );

    if (_filteredEvents.isNotEmpty) {
      content = ListView.builder(
        itemCount: _filteredEvents.length,
        itemBuilder: (context, index) => EventTile(
          _filteredEvents[index],
          onEdit: () => _addEvent(context, Mode.edit, _filteredEvents[index]),
          onDelete: () => _deleteEvent(_filteredEvents[index]),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sports Events'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Dropdown for category filtering
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<SportsCategory>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Filter by Category',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('All Categories'),
                ),
                ...SportsCategory.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        Icon(category.icon, color: Colors.blueAccent),
                        const SizedBox(width: 8),
                        Text(category.label),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // Events List
          Expanded(child: content),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addEvent(context, Mode.create, null),
        label: const Text('Create Event'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

class EventTile extends StatelessWidget {
  const EventTile(this.event,
      {super.key, required this.onEdit, required this.onDelete});

  final Event event;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  Widget _buildImage(Event event) {
    if (event.imageBytes != null) {
      return Image.memory(event.imageBytes!,
          width: 100, height: 100, fit: BoxFit.cover);
    } else if (event.imagePath.startsWith('/images')) {
      return Image.asset(event.imagePath,
          width: 100, height: 100, fit: BoxFit.cover);
    } else if (event.imagePath.isNotEmpty) {
      return Image.file(File(event.imagePath),
          width: 100, height: 100, fit: BoxFit.cover);
    } else {
      return Container(
        width: 100,
        height: 100,
        color: Colors.grey.shade200,
        child: const Icon(Icons.event, size: 50, color: Colors.grey),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMMMMd();
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _buildImage(event),
        ),
        title: Text(
          event.name,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.teal),
        ),
        subtitle: Text(
          '${formatter.format(event.date)} at ${event.time}',
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (String choice) {
            if (choice == 'Edit') {
              onEdit();
            } else if (choice == 'Delete') {
              onDelete();
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'Edit',
              child: Text('Edit'),
            ),
            const PopupMenuItem<String>(
              value: 'Delete',
              child: Text('Delete'),
            ),
          ],
        ),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsPage(event: event),
            ),
          );
        },
      ),
    );
  }
}
