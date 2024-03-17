import 'package:flutter/material.dart';
import 'package:life_navigator/button/round.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff54668e), Color(0xff273d70)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo1.png",
            ),
            Text(
              "Welcome To LifeNavigator",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xffd3d6db),
                fontFamily: 'Montserrat',
              ),
            ),
            Text(
              "Empowering Your Journey Through Events, Safety, and Sustainability!",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xffd3d6db),
                fontFamily: 'Montserrat',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                "Stay connected",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffd3d6db),
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            Text(
              "With your friends",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xffd3d6db),
                fontFamily: 'Montserrat',
              ),
            ),
            Padding(

              padding: const EdgeInsets.only(top: 50),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the radius as needed
                  ),backgroundColor: Colors.black
                ),
                child: Text(
                  "Get Staeted",
                  style: TextStyle(color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
