import 'package:week3/lecture/w8/w8-s2/inClass/models/expense.dart';

import '../models/event.dart';
import '../models/sport_category.dart';

final List<Event> Events = [
  Event(
    id: uuid.v1(),
    name: '4th Anniversary of RCU & Frisbee Clinic',
    description: '''
      Join the celebration with us! 🎉  
      Have fun at the Frisbee Team's 4th Anniversary and a free frisbee clinic, packed with excitement and experiences for all skill levels! 🥏  

      This is your chance to:  
      - Improve your skills and learn disc-throwing techniques.  
      - Meet new people and enjoy the thrill of the game.  
      - Participate in team games, exercises, and other fun activities with guidance from our skilled coaches! 🌟  

      Expect plenty of fun, learning, and community connections with energetic frisbee lovers.  
      Bring along your loved ones—partners, relatives, and friends who enjoy sports and fun! 🎈  

      📅 **Date:** 20 October 2024  
      🕒 **Time:** 8:00 AM - 12:00 PM  
      📍 **Location:** Boeung Keng Kang High School  

      Don't miss out on this opportunity—join us and make it a day to remember!
      ''',
    category: SportsCategory.frisbee,
    date: DateTime.parse('2024-10-20'),
    time: '8:00 AM - 12:00 PM',
    price: 'Free',
    location: 'Boeung Keng Kang High School',
    imagePath: '/images/frisbeeRCU.jpg',
  ),
  Event(
    id: uuid.v1(),
    name: 'City Football Match',
    description: 'Join us for an exciting football match in the city park.',
    category: SportsCategory.football,
    date: DateTime.parse('2024-06-28'),
    time: '4:00 PM',
    price: 'free',
    location: 'City Park Stadium',
    imagePath: '/images/football.jpg',
  ),
  Event(
    id: uuid.v1(),
    name: 'Tennis Singles Tournament',
    description: 'Compete in a fun tennis singles tournament.',
    category: SportsCategory.tennis,
    date: DateTime.parse('2024-06-28'),
    time: '10:00 AM',
    price: 'free',
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
    price: '3\$',
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
    price: '7\$',
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
    price: '8\$',
    location: 'Sunrise Park',
    imagePath: '/images/running.jpg',
  ),
  Event(
    id: uuid.v1(),
    name: 'Basketball Tournament',
    description: 'Participate in our 3v3 basketball tournament.',
    category: SportsCategory.basketball,
    date: DateTime.parse('2024-06-29'),
    time: '9:00 AM',
    price: '5\$',
    location: 'Indoor Sports Complex',
    imagePath: '/images/basketball.jpg',
  ),
  Event(
    id: uuid.v1(),
    name: 'Swimming Competition',
    description: 'Join our amateur swimming competition.',
    category: SportsCategory.swimming,
    date: DateTime.parse('2024-06-29'),
    time: '8:30 AM',
    price: '10\$',
    location: 'City Aquatic Center',
    imagePath: '/images/swimming.jpg',
  ),
  Event(
    id: uuid.v1(),
    name: 'Volleyball Beach Tournament',
    description: 'Beach volleyball tournament for all skill levels.',
    category: SportsCategory.volleyball,
    date: DateTime.parse('2024-06-30'),
    time: '10:00 AM',
    price: 'free',
    location: 'Sandy Beach',
    imagePath: '/images/volleyball.jpg',
  ),
];
