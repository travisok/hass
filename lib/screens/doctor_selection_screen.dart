import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'confirmation_screen.dart';

class DoctorSelectionScreen extends StatefulWidget {
  final String hospitalName;

  const DoctorSelectionScreen({super.key, required this.hospitalName});

  @override
  _DoctorSelectionScreenState createState() => _DoctorSelectionScreenState();
}

class _DoctorSelectionScreenState extends State<DoctorSelectionScreen> {
  final Map<String, List<String>> _hospitalDoctors = {
    'Hospital 1': ['Doctor 1', 'Doctor 2', 'Doctor 3'],
    'Hospital 2': ['Doctor 4', 'Doctor 5', 'Doctor 6'],
    'Hospital 3': ['Doctor 7', 'Doctor 8', 'Doctor 9'],
  };
  final Map<String, List<String>> _doctorTimeSlots = {};
  List<String> _doctors = [];
  String? _selectedDoctor;
  String? _selectedTimeSlot;
  bool _homeVisit = false;

  @override
  void initState() {
    super.initState();
    _doctors = _hospitalDoctors[widget.hospitalName]!;
    _generateDoctorTimeSlots();
  }

  void _generateDoctorTimeSlots() {
    final DateTime now = DateTime.now();
    final DateFormat displayFormat = DateFormat('EEEE, MMM d, yyyy');
    final DateFormat parseFormat = DateFormat('EEEE, MMM d, yyyy, h:mm a - h:mm a');

    final Map<String, List<String>> doctorSlots = {
      'Doctor 1': [
        '9:00 AM - 10:00 AM',
        '11:00 AM - 12:00 PM',
        '2:00 PM - 3:00 PM',
        '3:00 PM - 4:00 PM',
        '5:00 PM - 6:00 PM',
      ],
      'Doctor 2': [
        '8:00 AM - 9:00 AM',
        '10:00 AM - 11:00 AM',
        '1:00 PM - 2:00 PM',
        '3:00 PM - 4:00 PM',
        '4:00 PM - 5:00 PM',
      ],
      'Doctor 3': [
        '7:00 AM - 8:00 AM',
        '9:00 AM - 10:00 AM',
        '12:00 PM - 1:00 PM',
        '2:00 PM - 3:00 PM',
        '3:00 PM - 4:00 PM',
      ],
      'Doctor 4': [
        '10:00 AM - 11:00 AM',
        '11:00 AM - 12:00 PM',
        '1:00 PM - 2:00 PM',
        '3:00 PM - 4:00 PM',
        '4:00 PM - 5:00 PM',
      ],
      'Doctor 5': [
        '9:00 AM - 10:00 AM',
        '11:00 AM - 12:00 PM',
        '1:00 PM - 2:00 PM',
        '2:00 PM - 3:00 PM',
        '4:00 PM - 5:00 PM',
      ],
      'Doctor 6': [
        '8:00 AM - 9:00 AM',
        '10:00 AM - 11:00 AM',
        '12:00 PM - 1:00 PM',
        '2:00 PM - 3:00 PM',
        '3:00 PM - 4:00 PM',
      ],
      'Doctor 7': [
        '7:00 AM - 8:00 AM',
        '9:00 AM - 10:00 AM',
        '11:00 AM - 12:00 PM',
        '1:00 PM - 2:00 PM',
        '3:00 PM - 4:00 PM',
      ],
      'Doctor 8': [
        '8:00 AM - 9:00 AM',
        '10:00 AM - 11:00 AM',
        '12:00 PM - 1:00 PM',
        '2:00 PM - 3:00 PM',
        '4:00 PM - 5:00 PM',
      ],
      'Doctor 9': [
        '9:00 AM - 10:00 AM',
        '11:00 AM - 12:00 PM',
        '1:00 PM - 2:00 PM',
        '3:00 PM - 4:00 PM',
        '4:00 PM - 5:00 PM',
      ],
    };

    final Map<String, List<int>> doctorDays = {
      'Doctor 1': [2, 4, 6, 7, 2],
      'Doctor 2': [1, 2, 2, 4, 6],
      'Doctor 3': [1, 3, 4, 5, 7],
      'Doctor 4': [1, 3, 4, 6, 7],
      'Doctor 5': [1, 2, 4, 5, 7],
      'Doctor 6': [2, 4, 5, 6, 7],
      'Doctor 7': [1, 2, 3, 5, 7],
      'Doctor 8': [1, 2, 3, 4, 7],
      'Doctor 9': [1, 2, 3, 4, 5],
    };

    for (var doctor in _doctors) {
      _doctorTimeSlots[doctor] = [];
      List<String> slots = doctorSlots[doctor]!;
      List<int> days = doctorDays[doctor]!;

      for (int i = 0; i < 5; i++) {
        final DateTime date = now.add(Duration(days: days[i]));
        final String formattedDate = displayFormat.format(date);
        _doctorTimeSlots[doctor]!.add('$formattedDate, ${slots[i]}');
      }

      // Sort the time slots by date
      _doctorTimeSlots[doctor]!.sort((a, b) {
        DateTime dateA = parseFormat.parse(a);
        DateTime dateB = parseFormat.parse(b);
        return dateA.compareTo(dateB);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.hospitalName,
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
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select Doctor'),
                items: _doctors.map((doctor) {
                  return DropdownMenuItem(
                    value: doctor,
                    child: Text(doctor),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDoctor = value;
                    _selectedTimeSlot = null;
                  });
                },
                value: _selectedDoctor,
              ),
              if (_selectedDoctor != null) ...[
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Select Time Slot'),
                  items: _doctorTimeSlots[_selectedDoctor]!.map((timeSlot) {
                    return DropdownMenuItem(
                      value: timeSlot,
                      child: Text(timeSlot),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTimeSlot = value;
                    });
                  },
                  value: _selectedTimeSlot,
                ),
              ],
              SizedBox(height: 16),
              CheckboxListTile(
                title: Text('Opt for Home Visit'),
                value: _homeVisit,
                onChanged: (value) {
                  setState(() {
                    _homeVisit = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _selectedDoctor != null && _selectedTimeSlot != null
                    ? () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ConfirmationScreen(
                                doctorName: _selectedDoctor!,
                                timeSlot: _selectedTimeSlot!,
                                homeVisit: _homeVisit)));
                      }
                    : null,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
