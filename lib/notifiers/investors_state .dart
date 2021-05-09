import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/models/investor.dart';
import 'package:flutter/material.dart';

class InvestorsState extends ChangeNotifier {
  List<DocumentSnapshot> _supervisors = [], _filteredInvestors = [];
  StreamSubscription _subscription;
  int sortColumnIndex = 1;
  bool waiting = true, hasError = false, done = false, sortAscending = true;

  InvestorsState() {
    startStreaming();
  }

  List get getInvestors => _supervisors;
  List get getFilteredInvestors => _filteredInvestors;

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  startStreaming() async {
    _subscription =
        FirebaseFirestore.instance.collection('Investors').snapshots().listen(
      (data) {
        _filteredInvestors = _supervisors = data.docs.toList();
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

  searchInvestors(String searchKey) {
    _filteredInvestors = _supervisors.where((docSnapshot) {
      // print(docSnapshot.data()['dateOfBirth'] is Timestamp);
      // return false;
      Investor supervisor = Investor.fromMapObject(docSnapshot.data());
      return supervisor.name.toLowerCase().contains(searchKey.toLowerCase());
    }).toList();
    notifyListeners();
  }

  sortInvestorList(String columnName, int index, bool sorted) {
    sortColumnIndex = index;
    if (sortAscending) {
      sortAscending = false;
      _filteredInvestors.sort((a, b) {
        Investor supervisor1 = Investor.fromMapObject(a.data());
        Investor supervisor2 = Investor.fromMapObject(b.data());
        return supervisor1
            .toMap()[columnName]
            .compareTo(supervisor2.toMap()[columnName]);
      });
    } else {
      sortAscending = true;
      _filteredInvestors.sort((a, b) {
        Investor supervisor1 = Investor.fromMapObject(a.data());
        Investor supervisor2 = Investor.fromMapObject(b.data());
        return supervisor2
            .toMap()[columnName]
            .compareTo(supervisor1.toMap()[columnName]);
      });
    }
    notifyListeners();
  }
}
