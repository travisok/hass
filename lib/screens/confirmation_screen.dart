import 'package:flutter/material.dart';
import 'package:hass/confirmed_visits_notifier.dart';
import 'package:hass/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ConfirmationScreen extends StatelessWidget {
  final String hospitalName;
  final String doctorName;
  final String timeSlot;
  final bool homeVisit;

  const ConfirmationScreen(
      {super.key, required this.hospitalName, required this.doctorName, required this.timeSlot, required this.homeVisit});

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();

    Future<void> _speak(String text) async {
      await flutterTts.speak(text);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Confirmation',
            style: TextStyle(
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
              Text('Doctor: $doctorName', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('Time Slot: $timeSlot', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('Home Visit: ${homeVisit ? "Yes" : "No"}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Add the confirmed visit to the notifier
                  Provider.of<ConfirmedVisitsNotifier>(context, listen: false)
                      .addConfirmedVisit(ConfirmedVisit(
                    hospitalName: hospitalName,
                    doctorName: doctorName,
                    timeSlot: timeSlot,
                    homeVisit: homeVisit,
                  ));
                  // Navigate back to the home screen
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                  _speak('Your visit has been confirmed with $doctorName at $timeSlot. Home visit: ${homeVisit ? "Yes" : "No"}');
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
