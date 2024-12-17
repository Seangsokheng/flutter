import 'package:flutter/material.dart';

enum SportsCategory {
  football('Football', Icons.sports_soccer),
  tennis('Tennis', Icons.sports_tennis),
  basketball('Basketball', Icons.sports_basketball),
  frisbee('Frisbee', Icons.sports),
  cycling('Cycling', Icons.directions_bike),
  running('Running', Icons.directions_run);
  

  final String label;
  final IconData icon;

  const SportsCategory(this.label, this.icon);
}