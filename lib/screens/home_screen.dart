// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'DocDash',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontFamily: 'Montserrat',
//                 fontWeight: FontWeight.w500,
//                 ),
//                 ),
//           backgroundColor: const Color(0xFF03045E),
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextField(
//                 decoration: const InputDecoration(
//                   hintText: 'Search by name of hospital',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.search),
//                 ),
//                 onChanged: (text) {
//                   // Add your search logic here
//                   print('Search term: $text');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'doctor_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _hospitals = ['Hospital 1', 'Hospital 2', 'Hospital 3'];
  List<String> _filteredHospitals = [];

  @override
  void initState() {
    super.initState();
    _filteredHospitals = _hospitals;
  }

  void _filterHospitals(String query) {
    final filtered = _hospitals.where((hospital) {
      return hospital.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredHospitals = filtered;
    });
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
              fontWeight: FontWeight.w400
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
                decoration: InputDecoration(
                  hintText: 'Search by name of hospital',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (text) {
                  _filterHospitals(text);
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredHospitals.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_filteredHospitals[index]),
                      onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(
                             builder: (_) => DoctorSelectionScreen(hospitalName: _filteredHospitals[index])));
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
