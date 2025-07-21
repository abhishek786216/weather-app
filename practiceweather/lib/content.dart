import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  String weather = '';
  String displayResult = '';
  LinearGradient backgroundGradient = _defaultGradient;
  IconData? weatherIcon;

  final TextEditingController controller = TextEditingController();

  static const _defaultGradient = LinearGradient(
    colors: [Colors.blueGrey, Colors.grey],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  void finder(String city) async {
    try {
      String url =
          "https://api.openweathermap.org/data/2.5/weather?q=${city.toLowerCase()}&appid=47a67c111c7acc2f48933c0f90713c3e&units=metric";

      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String mainWeather = data['weather'][0]['main']
            .toString()
            .toLowerCase();

        // Change gradient and icon based on weather
        setState(() {
          displayResult =
              "City: ${data['name']}\nTemp: ${data['main']['temp']}°C\nCondition: ${data['weather'][0]['description']}";

          if (mainWeather.contains('cloud')) {
            backgroundGradient = LinearGradient(
              colors: [Colors.grey.shade600, Colors.blueGrey.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            );
            weatherIcon = Icons.cloud;
          } else if (mainWeather.contains('rain')) {
            backgroundGradient = LinearGradient(
              colors: [Colors.indigo, Colors.blue.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            );
            weatherIcon = Icons.umbrella;
          } else if (mainWeather.contains('clear')) {
            backgroundGradient = LinearGradient(
              colors: [Colors.lightBlue.shade300, Colors.yellow.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            );
            weatherIcon = Icons.wb_sunny;
          } else if (mainWeather.contains('snow')) {
            backgroundGradient = LinearGradient(
              colors: [Colors.blue.shade100, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            );
            weatherIcon = Icons.ac_unit;
          } else {
            backgroundGradient = _defaultGradient;
            weatherIcon = Icons.waves;
          }
        });
      } else {
        setState(() {
          displayResult =
              'Error: ${response.statusCode} - ${response.reasonPhrase}';
          backgroundGradient = LinearGradient(
            colors: [Colors.red, Colors.orange],
          );
        });
      }
    } catch (e) {
      setState(() {
        displayResult = 'Exception occurred: $e';
        backgroundGradient = LinearGradient(
          colors: [Colors.deepOrange, Colors.black],
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      decoration: BoxDecoration(gradient: backgroundGradient),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'ENTER CITY NAME',
                  labelStyle: TextStyle(
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white10,
                ),
                style: const TextStyle(
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
                onChanged: (value) {
                  weather = value.toUpperCase();
                  controller.value = TextEditingValue(
                    text: weather,
                    selection: TextSelection.collapsed(offset: weather.length),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () => finder(weather),
                child: const Text('Get Weather'),
              ),
              const SizedBox(height: 30),
              if (displayResult.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (weatherIcon != null)
                            Icon(weatherIcon, size: 50, color: Colors.white),
                          const SizedBox(height: 12),
                          Text(
                            displayResult,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
