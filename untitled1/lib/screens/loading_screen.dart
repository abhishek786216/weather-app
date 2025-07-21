import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() => runApp(MaterialApp(home: LoadingScreen()));

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  List<String> coordinates = [];
  String weatherDescription = '';
  double temperature = 0.0;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    List<String> result = await LocationService().fetchLocation();
    setState(() {
      coordinates = result;
      print('📍 Coordinates: $coordinates');
    });
    fetchWeather();
  }

  void fetchWeather() async {
    try {
      final lat = double.parse(coordinates[0].trim());
      final lon = double.parse(coordinates[1].trim());

      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=47a67c111c7acc2f48933c0f90713c3e&units=metric';

      print("🌐 Fetching weather from: $url");

      final response = await http.get(Uri.parse(url));

      print("📦 Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          weatherDescription = json['weather'][0]['description'];
          temperature = json['main']['temp'];
        });
      } else {
        print("❌ API Error: ${response.body}");
      }
    } catch (e) {
      print('🚨 Error fetching weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: coordinates.isEmpty
            ? SpinKitDoubleBounce(color: Colors.white, size: 50.0)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("📍 Latitude: ${coordinates[0]}"),
                  Text("📍 Longitude: ${coordinates[1]}"),
                  SizedBox(height: 20),
                  if (weatherDescription.isNotEmpty)
                    Column(
                      children: [
                        Text("🌤️ Weather: $weatherDescription"),
                        Text(
                          "🌡️ Temperature: ${temperature.toStringAsFixed(1)} °C",
                        ),
                      ],
                    ),
                ],
              ),
      ),
    );
  }
}
