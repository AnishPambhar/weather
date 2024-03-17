import 'dart:async';
import 'package:flutter/material.dart';
import 'package:life_navigator/weather_home.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds and then navigate to the next screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WeatherHome()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2d2a55),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlayAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 200.0),
            duration: const Duration(seconds: 3),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/nift.png",
                      height: value,
                    ),
                    Text(
                      "WelCome!!",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Montserrat",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
