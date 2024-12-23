import 'package:flutter/material.dart';
import 'package:week3/sport-event/data/event_data.dart';
import 'package:week3/sport-event/models/event.dart';
import 'package:week3/sport-event/models/sport_category.dart';
import 'package:week3/sport-event/pages/create_event_page.dart';
import 'package:week3/sport-event/widgets/categoryPIll.dart';
import 'package:week3/sport-event/widgets/eventCard.dart';
import 'package:week3/sport-event/widgets/header.dart';

enum Mode { create, edit }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

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
    return Events.where((event) => event.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(),
            _buildCategoryList(),
            _buildEventsList(),
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

  Widget _buildCategoryList() {
    return SizedBox(
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
                onTap: () => setState(() => _selectedCategory = category),
              )),
        ],
      ),
    );
  }

  Widget _buildEventsList() {
    return Expanded(
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
                onEdit: () =>
                    _addEvent(context, Mode.edit, _filteredEvents[index]),
                onDelete: () => _deleteEvent(_filteredEvents[index], index),
                onJoinToggle: () => _toggleJoin(_filteredEvents[index]),
              ),
            ),
    );
  }
}