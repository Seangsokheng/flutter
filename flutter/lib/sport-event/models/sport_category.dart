import 'package:flutter/material.dart';

enum SportsCategory {
  frisbee('Frisbee', Icons.sports),
  football('Football', Icons.sports_soccer),
  tennis('Tennis', Icons.sports_tennis),
  basketball('Basketball', Icons.sports_basketball),
  volleyball('Volleyball', Icons.sports_volleyball),
  swimming('Swimming', Icons.pool),
  cycling('Cycling', Icons.directions_bike),
  running('Running', Icons.directions_run),
  yoga('Yoga', Icons.self_improvement),
  baseball('Baseball', Icons.sports_baseball),
  golf('Golf', Icons.sports_golf);

  final String label;
  final IconData icon;

  const SportsCategory(this.label, this.icon);
}