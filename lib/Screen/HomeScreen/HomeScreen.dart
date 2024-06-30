import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/Models/WeatherModel.dart';

import 'package:weather/Screen/HomeScreen/HomeScreenController.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherController weatherController = Get.put(WeatherController());
  final TimeController timeController = Get.put(TimeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'W E A T H E R',
          style: TextStyle(fontSize: 12),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Obx(() {
            var weatherData = weatherController.weatherData.value;
            var weather = weatherData.weather.isNotEmpty
                ? weatherData.weather[0]
                : Weather(id: 0, main: '', description: '', icon: '');
            var temperature =
                weatherData.main.temp - 273.15; // Convert to Celsius
            var maxTemperature =
                weatherData.main.tempMax - 273.15; // Convert to Celsius
            var minTemperature =
                weatherData.main.tempMin - 273.15; // Convert to Celsius
            var windSpeed = weatherData.wind.speed;
            var humidity = weatherData.main.humidity;
            var weatherDescription = weather.main;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  weatherData.name, // Display city name dynamically
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  timeController.timeNow.value,
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 10),
                Text(
                  DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now()),
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10),
                Text(
                  '${temperature.toStringAsFixed(0)}°C', // Display temperature in Celsius
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 10),
                Text(
                  weatherDescription
                      .toUpperCase(), // Display weather description
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Icon(
                  Icons
                      .cloud, // Replace with dynamic weather icon based on weather.icon
                  size: 150,
                ),
                SizedBox(height: 20),
                Container(
                  height: 125,
                  width: Get.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Max: ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${maxTemperature.toStringAsFixed(0)}°C',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Min: ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${minTemperature.toStringAsFixed(0)}°C',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Wind: ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${windSpeed.toString()} m/s',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Humidity: ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '$humidity%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
