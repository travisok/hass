import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen ({super.key});

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
