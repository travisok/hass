import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: Column(
              children: [
                Container(
                  height: screenHeight * 0.78,
                  width: double.infinity,
                  color: Colors.grey.shade100,
                  child: Transform.scale(
                    scale: 0.37,
                    child: Image.asset(
                      'assets/mobile-logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * 0.22,
                  width: double.infinity,
                  // color: Colors.green,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Transform.scale(
                          scale: 0.7,
                          child: Container(
                            width: 400, // Set a fixed width
                            height: 80, // Set a fixed height
                            color: Colors.black,
                            child: const Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.7,
                          child: Container(
                            width: 400, // Set a fixed width
                            height: 80, // Set a fixed height
                            //color: Colors.grey.shade100,
                            decoration: BoxDecoration(
                                border: Border.all(
                              width: 3,
                              color: Colors.black,
                            )),
                            child: const Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                )
              ],
            )));
  }
}
