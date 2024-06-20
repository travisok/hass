import 'package:flutter/material.dart';

class ConfirmedVisit {
  final String doctorName;
  final String timeSlot;
  final bool homeVisit;

  ConfirmedVisit({
    required this.doctorName,
    required this.timeSlot,
    required this.homeVisit,
  });
}

class ConfirmedVisitsNotifier extends ChangeNotifier {
  final List<ConfirmedVisit> _confirmedVisits = [];

  List<ConfirmedVisit> get confirmedVisits => _confirmedVisits;

  void addConfirmedVisit(ConfirmedVisit visit) {
    _confirmedVisits.add(visit);
    notifyListeners();
  }
}
