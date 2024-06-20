import 'package:flutter/material.dart';
import 'package:hass/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen ({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the HomeScreen after 3 seconds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Center(
            // Center horizontally and vertically
            child: Container(
              width: 200,
              height: 200,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/vertical-logo.png',
                    //fit: BoxFit.contain,
                    width: 175,
                    height: 175
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
