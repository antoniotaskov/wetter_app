import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wetter_app/image.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  final String apiKey = 'privat';
  String cityName = "Bretten";
  double temperature = 0.0;
  String weatherDescription = "";
  String weatherMain = "";
  String errorMessage = "";

  Future<void> fetchWeather() async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric&lang=de';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          temperature = data['main']['temp'];
          weatherDescription = data['weather'][0]['description'];
          weatherMain = data['weather'][0]['main'];
          errorMessage = "";
        });
      } else {
        setState(() {
          errorMessage = "Keine Stadt gefunden";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Keine Stadt gefunden: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Color getBackgroundColor() {
    if (temperature <= 10) {
      return const Color.fromARGB(255, 170, 206, 236); // Cold
    } else if (temperature > 10 && temperature <= 25) {
      return const Color.fromARGB(255, 189, 213, 190); // Mild
    } else {
      return const Color.fromARGB(255, 213, 152, 148); // Hot
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          getBackgroundColor(), // Set the background color based on temperature
      appBar: AppBar(
        backgroundColor: getBackgroundColor(),
        title: const Text('Wetter App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(getImage(weatherMain)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Stadt eingeben',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                setState(() {
                  cityName = value;
                  fetchWeather();
                });
              },
            ),
            const SizedBox(height: 10),
            if (errorMessage.isEmpty)
              SizedBox(
                width: double
                    .infinity, // Card takes the full width of the parent container
                child: Card(
                  color: Colors.amber,
                  elevation: 20,
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Align text to the start of the Card
                      children: [
                        Text(
                          cityName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${temperature.toStringAsFixed(1)}°C',
                          style: const TextStyle(fontSize: 30),
                        ),
                        Text(
                          weatherDescription,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              )
            else
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.black),
              ),
          ],
        ),
      ),
    );
  }
}
