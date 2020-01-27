import 'package:flutter/material.dart';
import 'package:derm_pro/Home_screens/weather/weather_builder.dart';

class WeatherScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: WeatherBuilder().build()
    );
  }
  
}