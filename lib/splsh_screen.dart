import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/world.png",height: 100,color: Colors.green


                ),
                Text("LIFE NAVIGATOR ",style: TextStyle(fontWeight:FontWeight.w900,fontSize: 24 ),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
