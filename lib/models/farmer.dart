import 'package:cloud_firestore/cloud_firestore.dart';

class Farmer {
  String name, location, phone, farmerId, gender;
  int numFarms;
  bool enabled;
  String picture;
  double farmSize;
  DateTime dateOfBirth;
  List specializations;
  Farmer(
      {this.gender,
      this.farmerId,
      this.name,
      this.location,
      this.phone,
      this.numFarms,
      this.picture,
      this.dateOfBirth,
      this.farmSize,
      this.enabled = false,
      this.specializations});

  // Convert a Farmer object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (farmerId != null) {
      map['farmerId'] = farmerId;
    }
    map['name'] = name;
    map['phone'] = phone;
    map['location'] = location;
    map['numFarms'] = numFarms;
    map['picture'] = picture;
    map['farmSize'] = farmSize;
    map['dateOfBirth'] = dateOfBirth;
    map['gender'] = gender;
    map['enabled'] = enabled;
    map['specializations'] = specializations;
    return map;
  }

  Farmer.fromMapObject(Map<String, dynamic> map) {
    this.name = map['name'];
    this.phone = map['phone'];
    this.location = map['location'];
    this.numFarms = map['numFarms'];
    this.picture = map['picture'];
    this.farmSize = map['farmSize'];
    this.dateOfBirth = (map['dateOfBirth'] is Timestamp)
        ? map['dateOfBirth'].toDate()
        : (map['dateOfBirth'] is DateTime)
            ? map['dateOfBirth']
            : DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] * 1000);
    ;
    this.gender = map['gender'];
    this.enabled = map['enabled'] == null ? false : map['enabled'];
    this.specializations = (map['specializations'] is String)
        ? map['specializations'].toString().split(',')
        : map['specializations'];
  }
}
