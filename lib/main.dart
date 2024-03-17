import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:life_navigator/Events/home.dart';
import 'package:life_navigator/google_map.dart' as google_map; // Provide alias
import 'package:life_navigator/login.dart';
import 'package:life_navigator/onbording1.dart';
import 'package:life_navigator/show.dart';
import 'package:life_navigator/singup.dart';
import 'package:life_navigator/splsh_screen.dart';
import 'package:life_navigator/splsh_w.dart';
import 'package:life_navigator/weather_home.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); // Initialize Firebase

  runApp(const MyApp());
}

// void main() {
//   runApp(DevicePreview(builder: (BuildContext context)
//   => const MyApp()));
// }


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screen(), // Use the alias to specify the correct MapScreen
    );
  }
}
