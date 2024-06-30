// import 'package:geolocator/geolocator.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:weather/Models/WeatherModel.dart';

class TimeController extends GetxController {
  var timeNow = ''.obs;

  @override
  void onInit() {
    super.onInit();
    timeNow.value = formattedTime();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      timeNow.value = formattedTime();
    });
  }

  String formattedTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}

class WeatherController extends GetxController {
  var weatherData = WeatherModel(
    coord: Coord(lon: 0.0, lat: 0.0),
    weather: [],
    base: '',
    main: Main(
      temp: 0.0,
      feelsLike: 0.0,
      tempMin: 0.0,
      tempMax: 0.0,
      pressure: 0,
      humidity: 0,
      seaLevel: 0, // Provide a default value for seaLevel
      grndLevel: 0,
      cityName: 'Unknown',
    ),
    visibility: 0,
    wind: Wind(speed: 0.0, deg: 0),
    clouds: Clouds(all: 0),
    dt: 0,
    sys: Sys(
      type: 0, // Provide a default value for type
      id: 0, // Provide a default value for id
      country: '',
      sunrise: 0,
      sunset: 0,
    ),
    timezone: 0,
    id: 0,
    name: '',
    cod: 0,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchWeatherData();
  }

  void fetchWeatherData() async {
    var apiUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=33.6995&lon=73.0363&appid=adf0372fe5bedc55e7549e69301e811c');

    try {
      var response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        // Use update method to update reactive variable
        weatherData.value = WeatherModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  // Example of using ever to perform actions on weatherData change
  void exampleActionOnWeatherChange() {
    ever(weatherData, (_) {
      // Perform actions based on weatherData changes
      print('Weather data updated: ${weatherData.value.name}');
    });
  }
}

class SearchController extends GetxController {
  var searchResults = <WeatherModel>[].obs;
  var isLoading = false.obs;

  void searchCity(String cityName) async {
    if (cityName.isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;

    var apiUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=adf0372fe5bedc55e7549e69301e811c');

    try {
      var response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var weatherModel = WeatherModel.fromJson(jsonData);
        searchResults.clear();
        searchResults.add(weatherModel);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
