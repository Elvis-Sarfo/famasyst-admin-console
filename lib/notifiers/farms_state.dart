import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/models/farm.dart';
import 'package:farmasyst_admin_console/models/farmer.dart';
import 'package:flutter/material.dart';

class FarmsState extends ChangeNotifier {
  List<DocumentSnapshot> _farmers = [], _filteredFarms = [];
  StreamSubscription _subscription;
  int sortColumnIndex = 1;
  bool waiting = true, hasError = false, done = false, sortAscending = true;

  FarmsState() {
    startStreaming();
  }

  List get getFarms => _farmers;
  List get getFilteredFarms => _filteredFarms;

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  // List setFamers

  void updateSearchFarms(List filteredData) {
    _farmers = filteredData;
    notifyListeners();
  }

  startStreaming() async {
    _subscription =
        FirebaseFirestore.instance.collection('Farms').snapshots().listen(
      (data) {
        _filteredFarms = _farmers = data.docs.toList();
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
  //       FirebaseFirestore.instance.collection('Farms').snapshots();
  //   if (stream = null) {
  //     _subscription = stream.listen(
  //       (data) {
  //         _filteredFarms = _farmers = data.docs.toList();
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

  searchFarm(String searchKey) {
    _filteredFarms = _farmers.where((docSnapshot) {
      // print(docSnapshot.data()['dateOfBirth'] is Timestamp);
      // return false;
      Farm farmer = Farm.fromMapObject(docSnapshot.data());
      return farmer.farmId.toString().contains(searchKey.toLowerCase());
    }).toList();
    notifyListeners();
  }

  sortFarmList(String columnName, int index, bool sorted) {
    sortColumnIndex = index;
    if (sortAscending) {
      sortAscending = false;
      _filteredFarms.sort((a, b) {
        Farm farmer1 = Farm.fromMapObject(a.data());
        Farm farmer2 = Farm.fromMapObject(b.data());
        return farmer1
            .toMap()[columnName]
            .compareTo(farmer2.toMap()[columnName]);
      });
    } else {
      sortAscending = true;
      _filteredFarms.sort((a, b) {
        Farm farmer1 = Farm.fromMapObject(a.data());
        Farm farmer2 = Farm.fromMapObject(b.data());
        return farmer2
            .toMap()[columnName]
            .compareTo(farmer1.toMap()[columnName]);
      });
    }
    notifyListeners();
  }
}
