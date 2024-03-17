import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart'
    as locationService; // Renaming the prefix

class MapScreen extends StatefulWidget {
  final String city;

  const MapScreen({
    Key? key,
    required this.city, // Accept city as a parameter
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  locationService.LocationData? _currentLocation; // Renaming the prefix
  String _temperature = 'Loading...';
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  late String City; // Declare City variable
  String _apiKey = '8d6454a89dff871786a0307b0dbebbee';
  Map<String, dynamic>? _weatherData;
  bool _isLoading = true;
  // double _latitude = 0.0;
  // double _longitude = 0.0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    City = widget.city;
    // _fetchWeather(); // Call weather data fetching method
    _getWeatherData();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true; // Set isLoading to true when fetching data
    });
    locationService.Location location =
        locationService.Location(); // Renaming the prefix
    try {
      _currentLocation = await location.getLocation(); // Renaming the prefix
      setState(() {}); // Rebuild widget tree to reflect new location
      _isLoading = false;
    } catch (e) {
      _isLoading = false;

      print('Error getting current location: $e');
    }
  }

  Future<void> _getWeatherData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$City&units=metric&appid=$_apiKey'));

      if (response.statusCode == 200) {
        setState(() {
          _weatherData = json.decode(response.body);
        });
        _mapController.animateCamera(CameraUpdate.newLatLng(LatLng(
            _weatherData!['coord']['lat'], _weatherData!['coord']['lon'])));
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                if (_currentLocation != null)
                  GoogleMap(
                    onMapCreated: (controller) {
                      setState(() {
                        _mapController = controller;
                      });
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _weatherData != null
                            ? _weatherData!['coord']['lat']
                            : _currentLocation!.latitude,
                        _weatherData != null
                            ? _weatherData!['coord']['lon']
                            : _currentLocation!.longitude,
                      ),
                      zoom: 12,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: {
                      if (_currentLocation != null)
                        Marker(
                          markerId: MarkerId("currentLocation"),
                          position: LatLng(
                            _weatherData != null
                                ? _weatherData!['coord']['lat']
                                : _currentLocation!.latitude,
                            _weatherData != null
                                ? _weatherData!['coord']['lon']
                                : _currentLocation!.longitude,
                          ),
                          infoWindow: InfoWindow(title: 'Your Location'),
                        ),
                    },
                  ),
                if (_currentLocation == null)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                if (_isSearching)
                  Positioned(
                    top: 50,
                    left: 20,
                    right: 20,
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
                        controller: _searchController,
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
                                _searchController.clear();
                              });
                            },
                          ),
                        ),
                        onSubmitted: (value) {
                          _isSearching = false;

                          City = value;
                          _searchController.clear();

                          print(City);
                          _getWeatherData();
                        },
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildWeatherContainer(
                            'assets/w1.png',
                            'Temperature',
                            _weatherData != null
                                ? '${_weatherData!['main']['temp']}°C'
                                : "24.99°C"),
                        _buildWeatherContainer(
                            'assets/w2.png',
                            'wind speed',
                            _weatherData != null
                                ? '${_weatherData!['wind']['speed']} m/s'
                                : ""),
                        // _buildWeatherContainer('assets/w3.png', 'Visibility', '${_weatherData!['visibility']} meters'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isSearching = !_isSearching;
          });
        },
        child: Icon(Icons.search),
      ),
    );
  }

  Widget _buildWeatherContainer(String image, String name, String info) {
    return Container(
      height: 150,
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.blue.withOpacity(0.6),
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
