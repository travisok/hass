import 'package:flutter/material.dart';
import 'package:hass/confirmed_visits_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'doctor_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, List<String>> _hospitalDoctors = {
    'Edenbrook Hospital, Victoria Island, Lagos': ['Dr Gbenga Ishola', 'Dr Ethan Ramsey', 'Dr Tega Ovunwyi'],
    'Federal Medical Centre, Onitsha, Anambra': ['Dr Chukwumezie Osita', 'Dr Micah Okoye', 'Dr Abasikpongo Inyang'],
    'Mass Kenmore Hospital, Zaria, Kano': ['Dr Musa Dikko', 'Dr Alice Balewa', 'Dr Taylor Swift'],
  };
  final List<String> _hospitals = ['Edenbrook Hospital, Victoria Island, Lagos', 'Federal Medical Centre, Umuahia, Abia', 'Mass Kenmore Hospital, Zaria, Kano'];
  List<String> _filteredHospitals = [];
  bool _searchStarted = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _filteredHospitals = _hospitals;
    _searchController.addListener(_onSearchChanged);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _searchStarted = true;
        });
      }
    });
    _initSpeech();
  }

  void _initSpeech() async {
    bool available = await _speech.initialize();
    if (!available) {
      print("Speech recognition not available.");
    }
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _searchController.text = val.recognizedWords;
          }),
        );
      }
    }
  }

  void _stopListening() async {
    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
    }
  }

  void _onSearchChanged() {
    _filterHospitals(_searchController.text);
  }

  void _filterHospitals(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredHospitals = _hospitals;
      });
    } else {
      final filtered = _hospitals.where((hospital) {
        return hospital.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        _filteredHospitals = filtered;
      });
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'DocDash',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: const Color(0xFF03045E),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      decoration: const InputDecoration(
                        hintText: 'Search by name of hospital',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    onPressed: _isListening ? _stopListening : _startListening,
                  ),
                ],
              ),
              if (_searchStarted)
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredHospitals.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredHospitals[index]),
                        onTap: () {
                          _speak('Navigating to doctor selection for ${_filteredHospitals[index]}');
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => DoctorSelectionScreen(
                              hospitalName: _filteredHospitals[index],
                            ),
                          ));
                        },
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              const Text(
                'Confirmed Visits',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Consumer<ConfirmedVisitsNotifier>(
                  builder: (context, notifier, child) {
                    return ListView.builder(
                      itemCount: notifier.confirmedVisits.length,
                      itemBuilder: (context, index) {
                        final visit = notifier.confirmedVisits[index];
                        return ListTile(
                          title: Text('${visit.doctorName} - ${visit.timeSlot}'),
                          subtitle: Text('Home Visit: ${visit.homeVisit ? "Yes" : "No"}'),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
