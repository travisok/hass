import 'package:flutter/material.dart';
import 'package:hass/confirmed_visits_notifier.dart';
import 'package:provider/provider.dart';
import 'doctor_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _hospitals = ['Hospital 1', 'Hospital 2', 'Hospital 3'];
  List<String> _filteredHospitals = [];
  bool _searchStarted = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _filteredHospitals = _hospitals;

    // Add listener to focus node to detect focus changes
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _searchStarted = true;
        });
      }
    });
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
              TextField(
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  hintText: 'Search by name of hospital',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (text) {
                  _filterHospitals(text);
                },
              ),
              if (_searchStarted)
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredHospitals.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredHospitals[index]),
                        onTap: () {
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
                          subtitle: Text(
                              'Home Visit: ${visit.homeVisit ? "Yes" : "No"}'),
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

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
