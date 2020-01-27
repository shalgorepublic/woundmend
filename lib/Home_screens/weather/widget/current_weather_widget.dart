import 'package:flutter/material.dart';
import 'weather_widget.dart';
import 'forecast_widget.dart';
import 'package:derm_pro/Home_screens/weather/weather_result.dart';
import 'package:derm_pro/Home_screens/weather/weather_use_case.dart';

class CurrentWeatherPage extends StatefulWidget {

  final WeatherUseCase weatherUseCase;
  static final Key progressKey = Key("current_weather_widget_progress");
  static final Key weatherKey = Key("current_weather_widget_weather");
  static final Key errorKey = Key("current_weather_widget_error");

  CurrentWeatherPage({Key key, this.weatherUseCase}) : super(key: key);

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();

}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).backgroundColor,
        title: Text("UV Index"),
        /*actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Reload',
              onPressed: () {
                setState(() {

                });    
              },
            )
        ]*/
      ),
      body: Center(
        child: FutureBuilder<WeatherResult>(
            future: widget.weatherUseCase.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                WeatherResult weatherResult = snapshot.data;
                return _drawWeather(weatherResult);
              } else if (snapshot.hasError) {
                return Text("Helo weather ${snapshot.error}", key: CurrentWeatherPage.errorKey);
              }
              return CircularProgressIndicator(key: CurrentWeatherPage.progressKey);
            },
          ),
      )
    );
  }

  ListView _drawWeather(WeatherResult weatherResult) {
    ListView listView =  ListView(children: <Widget>[
    Container(
    key: CurrentWeatherPage.weatherKey,
      margin: EdgeInsets.all(0),
      child: Padding(padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            WeatherPage(weather: weatherResult.weather),
           // ForecastPage(forecast: weatherResult.forecast)
          ],
        ),
      ),
    )
    ],);

    return listView;
  }

}