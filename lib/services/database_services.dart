import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DatabaseServices {
  static Future<QuerySnapshot> getDataFromDatabase(String collection) async {
    await Firebase.initializeApp();
    var db = FirebaseFirestore.instance;
    CollectionReference reference = db.collection(collection);
    return reference.get();
  }

  static Future<QuerySnapshot> querySingleUserById(
      String userId, String collection) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore
        .collection(collection)
        .where('id', isEqualTo: userId)
        .get();
  }

  static Future<QuerySnapshot> queryFromDatabaseByField(
      String collection, String fieldName, dynamic value) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore
        .collection(collection)
        .where(fieldName, isEqualTo: value)
        .get();
  }

  static Future<String> uploadFile(
      var file, String folederPath, String filename) async {
    var _filename = filename == null
        ? (kIsWeb)
            ? DateTime.now().toString()
            : getFileName(file)
        : filename;
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref('$folederPath/$_filename');

    firebase_storage.TaskSnapshot storageTaskSnapshot = (!kIsWeb)
        ? await reference.putFile(file)
        : await reference.putBlob(file);
    final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static String getFileName(File file) {
    var path = file.path.split('/');
    var name = path.last;
    return name;
  }

  static updateDocument(String collection, String docId, Map update) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore.collection(collection).doc(docId).update(update);
  }

  static setDocument(String collection, String docId, Map update) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore.collection(collection).doc(docId).set(update);
  }

  static Future<DocumentReference> saveData(String collection, Map data) async {
    return await FirebaseFirestore.instance.collection(collection).add(data);
  }
}
