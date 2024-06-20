import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  final String doctorName;
  final String timeSlot;
  final bool homeVisit;

  const ConfirmationScreen(
      {super.key, required this.doctorName, required this.timeSlot, required this.homeVisit});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Confirmation',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
          ),
          backgroundColor: const Color(0xFF03045E),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Doctor: $doctorName', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Time Slot: $timeSlot', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Home Visit: ${homeVisit ? "Yes" : "No"}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Perform final booking action
                },
                child: Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
