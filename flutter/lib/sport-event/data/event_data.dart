import 'package:week3/lecture/w8/w8-s2/inClass/models/expense.dart';

import '../models/event.dart';
import '../models/sport_category.dart';

final List<Event> Events = [
  Event(
    id: uuid.v1(),
    name: 'City Football Match',
    description: 'Join us for an exciting football match in the city park.',
    category: SportsCategory.football,
    date: DateTime.parse('2024-06-28'),
    time: '4:00 PM',
    location: 'City Park Stadium',
    imagePath: '/images/football.jpg',
  ),
  Event(
    id: uuid.v1(),
    name: 'Tennis Singles Tournament',
    description: 'Compete in a fun tennis singles tournament.',
    category: SportsCategory.tennis,
    date:DateTime.parse('2024-06-28'),
    time: '10:00 AM',
    location: 'Green Valley Tennis Court',
    imagePath: '/images/tennis.jpg',
  ),
  Event(
    id: uuid.v1(),
    name: 'Ultimate Frisbee Fun',
    description: 'Play ultimate frisbee with friends!',
    category: SportsCategory.frisbee,
    date: DateTime.parse('2024-06-28'),
    time: '3:00 PM',
    location: 'Central Park Field 3',
    imagePath: '/images/frisbee.jpg',
  ),
  Event(
    id: uuid.v1(),
    name: 'City Cycling Race',
    description: 'Join a thrilling cycling race through the city.',
    category: SportsCategory.cycling,
    date: DateTime.parse('2024-06-28'),
    time: '8:00 AM',
    location: 'Main Street Circuit',
    imagePath: '/images/cycling.jpg',
  ),
  Event(
    id: uuid.v1(),
    name: 'Morning Running Group',
    description: 'Start your day with a healthy group run!',
    category: SportsCategory.running,
    date: DateTime.parse('2024-06-27'),
    time: '6:30 AM',
    location: 'Sunrise Park',
    imagePath: '/images/running.jpg',
  ),
];
