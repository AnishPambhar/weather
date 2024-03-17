import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:life_navigator/google_map.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({Key? key}) : super(key: key);

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  bool _isSearching = false;
  TextEditingController _cityController = TextEditingController();
  String _apiKey =
      '8d6454a89dff871786a0307b0dbebbee'; // Replace with your actual API key

  Map<String, dynamic>? _weatherData;
  List<String> data = [];
  List<String> data1 = [];
  List<String> image = [
    "assets/discription.png",
    "assets/degree.png",
    "assets/wind.png",
  ];
  List<String> image1 = [
    "assets/visibility.png",
    "assets/humidity.png",
    "assets/pressure.png",
  ];
  List<String> data_1 = [
    "Description",
    "Wind Degree",
    "Wind Speed",
  ];
  List<String> data_2 = [
    "Visibility",
    "Humidity",
    "Pressure",
  ];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController(text: 'Surat');
    _getWeatherData();
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _getWeatherData() async {
    setState(() {
      _isLoading = true; // Set isLoading to true when fetching data
    });
    final String city = _cityController.text.trim();

    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$_apiKey'));

      if (response.statusCode == 200) {
        setState(() {
          _weatherData = json.decode(response.body);

          // Update data list with weather details
          if (_weatherData != null) {
            data = [
              _weatherData!['weather'][0]['description'],
              '${_weatherData!['wind']['deg']}',
              '${_weatherData!['wind']['speed']} m/s',
            ];
            data1 = [
              '${_weatherData!['visibility']} meters',
              '${_weatherData!['main']['humidity']}%',
              '${_weatherData!['main']['pressure']} hPa'
            ];
          }
          _isLoading = false; // Set isLoading to false after data is fetched
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error: $e');
      _isLoading = false; // Set isLoading to false if there's an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2d2a54),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            _isSearching
                ? Padding(
              padding: const EdgeInsets.only(
                  top: 30, right: 20, left: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: 'Search City',
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          _isSearching = false;
                          _cityController.clear();
                        });
                      },
                    ),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      _isSearching = false;
                    });
                    _getWeatherData();
                  },
                ),
              ),
            )
                : Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Today',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          fontFamily: "Montserrat")),
                  if (_weatherData != null &&
                      _weatherData!['name'] != null)
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return MapScreen(
                                city: _cityController.text.toString(),
                              );
                            }));
                      },
                      child: Text(_weatherData!['name'],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                              fontFamily: "Montserrat")),
                    ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearching = !_isSearching;
                        _cityController.clear();
                      });
                      print(_isSearching);
                    },
                    icon: Icon(Icons.search_rounded),
                    color: Colors.white,
                    iconSize: 30,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 40),
              child: Image.asset(
                "assets/w_home.png",
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            if (_weatherData != null &&
                _weatherData!['main'] != null &&
                _weatherData!['main']['temp'] != null)
              Text("${_weatherData!['main']['temp']}°",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 29,
                      fontFamily: "Montserrat")),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0),
                          child: _buildWeatherContainer(
                            image[index],
                            data_1[index],
                            data[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: data1.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0),
                          child: _buildWeatherContainer(
                            image1[index],
                            data_2[index],
                            data1[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherContainer(String image, String name, String info) {
    return Container(
      height: 150,
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Color(0xffd7d8f0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 50),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              fontFamily: "Montserrat",
              color: Colors.black,
            ),
          ),
          Text(
            info,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              fontFamily: "Montserrat",
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
