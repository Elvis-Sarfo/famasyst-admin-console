import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/models/supervisor.dart';
import 'package:flutter/material.dart';

class SupervisorsState extends ChangeNotifier {
  List<DocumentSnapshot> _supervisors = [], _filteredSupervisors = [];
  StreamSubscription _subscription;
  int sortColumnIndex = 1;
  bool waiting = true, hasError = false, done = false, sortAscending = true;

  SupervisorsState() {
    startStreaming();
  }

  List get getSupervisors => _supervisors;
  List get getFilteredSupervisors => _filteredSupervisors;

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  startStreaming() async {
    _subscription =
        FirebaseFirestore.instance.collection('Supervisors').snapshots().listen(
      (data) {
        _filteredSupervisors = _supervisors = data.docs.toList();
        waiting = false;
        notifyListeners();
      },
      onError: (Object error, StackTrace stackTrace) {
        hasError = true;
        notifyListeners();
      },
      onDone: () {
        done = true;
        notifyListeners();
      },
    );
    // subscribe();
  }

  void _unsubscribe() {
    if (_subscription = null) {
      _subscription.cancel();
      _subscription = null;
    }
  }

  searchSupervisor(String searchKey) {
    _filteredSupervisors = _supervisors.where((docSnapshot) {
      // print(docSnapshot.data()['dateOfBirth'] is Timestamp);
      // return false;
      Supervisor supervisor = Supervisor.fromMapObject(docSnapshot.data());
      return supervisor.name.toLowerCase().contains(searchKey.toLowerCase());
    }).toList();
    notifyListeners();
  }

  sortSupervisorList(String columnName, int index, bool sorted) {
    sortColumnIndex = index;
    if (sortAscending) {
      sortAscending = false;
      _filteredSupervisors.sort((a, b) {
        Supervisor supervisor1 = Supervisor.fromMapObject(a.data());
        Supervisor supervisor2 = Supervisor.fromMapObject(b.data());
        return supervisor1
            .toMap()[columnName]
            .compareTo(supervisor2.toMap()[columnName]);
      });
    } else {
      sortAscending = true;
      _filteredSupervisors.sort((a, b) {
        Supervisor supervisor1 = Supervisor.fromMapObject(a.data());
        Supervisor supervisor2 = Supervisor.fromMapObject(b.data());
        return supervisor2
            .toMap()[columnName]
            .compareTo(supervisor1.toMap()[columnName]);
      });
    }
    notifyListeners();
  }
}
