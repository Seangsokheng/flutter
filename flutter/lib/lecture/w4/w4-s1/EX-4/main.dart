import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Padding(
          padding: EdgeInsets.all(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WeatherCard(
                  week: Week.monday,
                  weather: Weather.sunny,
                  temperatorMax: "30°C",
                  temperatorMin: "20°C",
                  iconColor: Colors.orange),
              SizedBox(width: 20),
              WeatherCard(
                  week: Week.tuesday,
                  weather: Weather.rainy,
                  temperatorMax: "25°C",
                  temperatorMin: "18°C",
                  iconColor: Colors.blue),
              SizedBox(width: 20),
              WeatherCard(
                  week: Week.wednesday,
                  weather: Weather.cloudy,
                  temperatorMax: "22°C",
                  temperatorMin: "15°C",
                  iconColor: Colors.grey),
              SizedBox(width: 20),
              WeatherCard(
                  week: Week.thursday,
                  weather: Weather.snowy,
                  temperatorMax: "0°C",
                  temperatorMin: "-5°C",
                  iconColor: Colors.lightBlue),
              SizedBox(width: 20),
              WeatherCard(
                  week: Week.friday,
                  weather: Weather.sunny,
                  temperatorMax: "28°C",
                  temperatorMin: "18°C",
                  iconColor: Colors.yellow),
              SizedBox(width: 20),
              WeatherCard(
                  week: Week.saturday,
                  weather: Weather.cloudy,
                  temperatorMax: "21°C",
                  temperatorMin: "16°C",
                  iconColor: Colors.grey),
              SizedBox(width: 20),
              WeatherCard(
                  week: Week.sunday,
                  weather: Weather.rainy,
                  temperatorMax: "24°C",
                  temperatorMin: "17°C",
                  iconColor: Colors.blue),
            ],
          ),
        ),
      ),
    ),
  );
}

enum Week {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

enum Temperator {
  min,
  max,
}

enum Weather {
  sunny,
  rainy,
  cloudy,
  snowy,
}

class WeatherCard extends StatelessWidget {
  final Week week;
  final Weather weather;
  final String temperatorMin;
  final String temperatorMax;
  final Color iconColor;
  String getWeekText(Week week) {
    switch (week) {
      case Week.monday:
        return 'Mon';
      case Week.tuesday:
        return 'Tue';
      case Week.wednesday:
        return 'Wed';
      case Week.thursday:
        return 'Thu';
      case Week.friday:
        return 'Fri';
      case Week.saturday:
        return 'Sat';
      case Week.sunday:
        return 'Sun';
    }
  }

  // Map Weather enum to appropriate icons
  IconData getWeatherIcon(Weather weather) {
    switch (weather) {
      case Weather.sunny:
        return Icons.sunny;
      case Weather.rainy:
        return Icons.umbrella;
      case Weather.cloudy:
        return Icons.cloud;
      case Weather.snowy:
        return Icons.ac_unit;
    }
  }

  const WeatherCard(
      {required this.week,
      required this.weather,
      required this.temperatorMax,
      required this.temperatorMin,
      required this.iconColor,
      super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          // color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getWeekText(week),
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Icon(
              getWeatherIcon(weather),
              size: 40,
              color: iconColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(temperatorMax),
                const SizedBox(width: 8),
                Text(temperatorMin),
              ],
            )
          ],
        ),
      ),
    );
  }
}
