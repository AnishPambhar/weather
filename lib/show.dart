import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late TextEditingController _cityController;
  String _apiKey = '8d6454a89dff871786a0307b0dbebbee'; // Replace with your actual API key

  Map<String, dynamic>? _weatherData;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController(text: 'London');
    _getWeatherData();
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _getWeatherData() async {
    final String city = _cityController.text.trim();
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$_apiKey'));

      if (response.statusCode == 200) {
        setState(() {
          _weatherData = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
              ),
              onSubmitted: (_) => _getWeatherData(),
            ),
            SizedBox(height: 20.0),
            _weatherData == null
                ? CircularProgressIndicator()
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'City: ${_weatherData!['name']}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Temperature: ${_weatherData!['main']['temp']}°C',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Description: ${_weatherData!['weather'][0]['description']}',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  'lon: ${_weatherData!['coord']['lon']}',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

