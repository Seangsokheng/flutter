import 'package:flutter/material.dart';
import 'package:week3/w6/w6-s1/EXERCISE-2/model/profile_tile_model.dart';
 
ProfileData ronanProfile = ProfileData(
    name: "Ronan",
    position: "Flutter Developer",
    avatarUrl: 'assets/w5-s2/aang.png',
    tiles: [
      TileData( icon: Icons.phone, title: "Phone Number", value: "+123 456 7890"),
      TileData(icon: Icons.location_on, title: "Address", value: "123 Cambodia"),
      TileData(icon: Icons.email, title: "Mail", value: "ronan.ogogr@cadt.edu"),
    ]);
    
ProfileData hengProfile = ProfileData(
  name: "Heng",
  position: "Backend Developer",
  avatarUrl: 'assets/w5-s2/heng.png',
  tiles: [
    TileData(icon: Icons.phone, title: "Phone Number", value: "+987 654 3210"),
    TileData(icon: Icons.location_on, title: "Address", value: "456 Phnom Penh"),
    TileData(icon: Icons.email, title: "Mail", value: "heng.ogogr@cadt.edu"),
  ],
);