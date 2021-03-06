import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/models/farmer.dart';
import 'package:flutter/material.dart';

class FarmersState extends ChangeNotifier {
  List<DocumentSnapshot> _farmers = [], _filteredFarmers = [];
  StreamSubscription _subscription;
  int sortColumnIndex = 1;
  bool waiting = true, hasError = false, done = false, sortAscending = true;

  FarmersState() {
    startStreaming();
  }

  List get getFarmers => _farmers;
  List get getFilteredFarmers => _filteredFarmers;

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  // List setFamers

  void updateSearchFarmers(List filteredData) {
    _farmers = filteredData;
    notifyListeners();
  }

  startStreaming() async {
    _subscription =
        FirebaseFirestore.instance.collection('Farmers').snapshots().listen(
      (data) {
        _filteredFarmers = _farmers = data.docs.toList();
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
  //       FirebaseFirestore.instance.collection('Farmers').snapshots();
  //   if (stream = null) {
  //     _subscription = stream.listen(
  //       (data) {
  //         _filteredFarmers = _farmers = data.docs.toList();
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

  searchFarmer(String searchKey) {
    _filteredFarmers = _farmers.where((docSnapshot) {
      // print(docSnapshot.data()['dateOfBirth'] is Timestamp);
      // return false;
      Farmer farmer = Farmer.fromMapObject(docSnapshot.data());
      return farmer.name.toLowerCase().contains(searchKey.toLowerCase());
    }).toList();
    notifyListeners();
  }

  sortFarmerList(String columnName, int index, bool sorted) {
    sortColumnIndex = index;
    if (sortAscending) {
      sortAscending = false;
      _filteredFarmers.sort((a, b) {
        Farmer farmer1 = Farmer.fromMapObject(a.data());
        Farmer farmer2 = Farmer.fromMapObject(b.data());
        return farmer1
            .toMap()[columnName]
            .compareTo(farmer2.toMap()[columnName]);
      });
    } else {
      sortAscending = true;
      _filteredFarmers.sort((a, b) {
        Farmer farmer1 = Farmer.fromMapObject(a.data());
        Farmer farmer2 = Farmer.fromMapObject(b.data());
        return farmer2
            .toMap()[columnName]
            .compareTo(farmer1.toMap()[columnName]);
      });
    }
    notifyListeners();
  }
}
