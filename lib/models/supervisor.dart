import 'package:cloud_firestore/cloud_firestore.dart';

class Supervisor {
  String name, location, phone, id, gender, email;
  String picture;
  DateTime dateOfBirth;
  bool enabled;
  List specializations;
  Supervisor({
    this.gender,
    this.id,
    this.name,
    this.location,
    this.phone,
    this.email,
    this.picture,
    this.dateOfBirth,
    this.enabled,
    this.specializations = const [],
  });

  // Convert a Farmer object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['location'] = location;
    map['picture'] = picture;
    map['dateOfBirth'] = dateOfBirth;
    map['gender'] = gender;
    map['enabled'] = enabled;
    map['specializations'] = specializations;
    return map;
  }

  Supervisor.fromMapObject(Map<String, dynamic> map) {
    this.name = map['name'];
    this.phone = map['phone'];
    this.email = map['email'];
    this.location = map['location'];
    this.picture = map['picture'];
    this.gender = map['gender'];
    this.dateOfBirth = (map['dateOfBirth'] is Timestamp)
        ? map['dateOfBirth'].toDate()
        : (map['dateOfBirth'] is DateTime)
            ? map['dateOfBirth']
            : DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] * 1000);
    this.gender = map['gender'];
    this.enabled = map['enabled'] == null ? false : map['enabled'];
    this.specializations = (map['specializations'] is String)
        ? map['specializations'].toString().split(',')
        : map['specializations'] != null
            ? map['specializations']
            : [];
  }
}
