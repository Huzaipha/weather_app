// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/Models/WeatherModel.dart';
import 'package:weather/Screen/HomeScreen/HomeScreenController.dart' as home;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final home.WeatherController weatherController =
      Get.put(home.WeatherController());
  final home.TimeController timeController = Get.put(home.TimeController());
  final home.SearchController searchController =
      Get.put(home.SearchController());
  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(
        'HELOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO\t\t\tHELOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO\nhelooooooooooooooooooooooooooooooooo\t\t\t\t\thelooooooooooooooooooo');
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
          padding: EdgeInsets.all(8),
          width: Get.width,
          margin: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(),
                child: Center(
                  child: TextField(
                    controller: searchTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search City',
                      labelStyle: TextStyle(fontSize: 8),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.deepPurple,
                        ),
                        onPressed: () {
                          searchController
                              .searchCity(searchTextController.text);
                        },
                      ),
                    ),
                    onSubmitted: (value) {
                      searchController.searchCity(value);
                    },
                  ),
                ),
              ),
              Obx(() {
                if (searchController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (searchController.searchResults.isNotEmpty) {
                  var weatherData = searchController.searchResults[0];
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
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      _buildWeatherIcon(weather
                          .main), // Display weather icon based on description
                      SizedBox(height: 5),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                } else {
                  return Obx(() {
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
                          DateFormat('EEEE, MMMM d, yyyy')
                              .format(DateTime.now()),
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
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        _buildWeatherIcon(weather
                            .main), // Display weather icon based on description
                        SizedBox(
                          height: 5,
                        ),

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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                  });
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherIcon(String weatherDescription) {
    switch (weatherDescription) {
      case 'Rain':
        return Icon(
          Icons.water,
          size: 150,
        );
      case 'Clear':
        return Icon(
          Icons.wb_sunny,
          size: 150,
        );
      case 'Clouds':
        return Icon(
          Icons.cloud,
          size: 150,
        );
      default:
        return Icon(
          Icons.cloud,
          size: 150,
        );
    }
  }
}
