import 'package:cloud_firestore/cloud_firestore.dart';

class Investment {
  String input, payback, id;
  Map farm, inverstor, farmer;
  bool approved, accepted;
  DateTime time, startTime, endTime;
  Investment({
    this.input,
    this.payback,
    this.farm,
    this.farmer,
    this.inverstor,
    this.id,
    this.approved = false,
    this.accepted = false,
  }) : this.time = DateTime.now();

  // Convert a Farmer object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['input'] = input;
    map['id'] = id;
    map['payback'] = payback;
    map['farm'] = farm;
    map['farmer'] = farmer;
    map['inverstor'] = inverstor;
    map['accepted'] = accepted;
    map['approved'] = approved;
    map['time'] = time;
    return map;
  }

  Investment.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    input = map['input'];
    payback = map['payback'];
    farm = map['farm'];
    farmer = map['farmer'];
    inverstor = map['inverstor'];
    accepted = map['accepted'];
    approved = map['approved'];
    time = (map['time'] is Timestamp) ? map['time'].toDate() : map['time'];
  }
}
