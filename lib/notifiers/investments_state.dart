import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/models/farm.dart';
import 'package:farmasyst_admin_console/models/investment.dart';
import 'package:farmasyst_admin_console/models/investment.dart';
import 'package:flutter/material.dart';

class InvestmentsState extends ChangeNotifier {
  List<DocumentSnapshot> _investments = [], _filteredInvestments = [];
  StreamSubscription _subscription;
  int sortColumnIndex = 1;
  bool waiting = true, hasError = false, done = false, sortAscending = true;

  InvestmentsState() {
    startStreaming();
  }

  List get getInvestments => _investments;
  List get getFilteredInvestments => _filteredInvestments;

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  // List setFamers

  void updateSearchInvestments(List filteredData) {
    _investments = filteredData;
    notifyListeners();
  }

  startStreaming() async {
    _subscription =
        FirebaseFirestore.instance.collection('Investments').snapshots().listen(
      (data) {
        _filteredInvestments = _investments = data.docs.toList();
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

  // _notifyListeners() {}

  // void subscribe() {
  //   Stream<QuerySnapshot> stream =
  //       FirebaseFirestore.instance.collection('Investments').snapshots();
  //   if (stream = null) {
  //     _subscription = stream.listen(
  //       (data) {
  //         _filteredInvestments = _investments = data.docs.toList();
  //         notifyListeners();
  //       },
  //       onError: (Object error, StackTrace stackTrace) {},
  //       onDone: () {
  //         notifyListeners();
  //       },
  //     );
  //   }
  //   notifyListeners();
  // }

  void _unsubscribe() {
    if (_subscription = null) {
      _subscription.cancel();
      _subscription = null;
    }
  }

  searchInvestment(String searchKey) {
    _filteredInvestments = _investments.where((docSnapshot) {
      // print(docSnapshot.data()['dateOfBirth'] is Timestamp);
      // return false;
      Investment investment = Investment.fromMapObject(docSnapshot.data());
      return investment.id.contains(searchKey.toLowerCase());
    }).toList();
    notifyListeners();
  }

  sortInvestmentList(String columnName, int index, bool sorted) {
    sortColumnIndex = index;
    if (sortAscending) {
      sortAscending = false;
      _filteredInvestments.sort((a, b) {
        Investment investment1 = Investment.fromMapObject(a.data());
        Investment investment2 = Investment.fromMapObject(b.data());
        return investment1
            .toMap()[columnName]
            .compareTo(investment2.toMap()[columnName]);
      });
    } else {
      sortAscending = true;
      _filteredInvestments.sort((a, b) {
        Investment investment1 = Investment.fromMapObject(a.data());
        Investment investment2 = Investment.fromMapObject(b.data());
        return investment2
            .toMap()[columnName]
            .compareTo(investment1.toMap()[columnName]);
      });
    }
    notifyListeners();
  }
}
