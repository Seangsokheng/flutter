import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: const Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HobbieCard(hobbie: "Travelling", icon: Icons.travel_explore,color: Colors.green,),
              SizedBox(
                height: 10,
              ),
              HobbieCard(hobbie: "Frisbee",icon: Icons.disc_full, color: Colors.orange,),
              SizedBox(
                height: 10,
              ),
              HobbieCard(hobbie: "Music", icon: Icons.music_note,color: Colors.yellow,),
            ],
          ),
        ),
      ),
    ),
  );
}

class HobbieCard extends StatelessWidget {
  final Color color;
  final String hobbie;
  final IconData icon;

  const HobbieCard({required this.hobbie, required this.icon, this.color = Colors.blue, super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 80,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child:  Center(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 30),
                child: Icon(
                  icon,
                ),
              ),
              Text(
                hobbie,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
