// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/models/farmer.dart';
import 'package:farmasyst_admin_console/services/auth_services.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';

Future<String> saveNewFarmer(Farmer farmer,
    {var profilePic, String pictureName}) async {
  var docs = await DatabaseServices.queryFromDatabaseByField(
      'Farmers', 'phone', farmer.phone);
  if (docs.docs.isEmpty) {
    DocumentReference docSnapshot =
        await DatabaseServices.saveData('Farmers', farmer.toMap());

    var imageUrl = (profilePic != null)
        ? await DatabaseServices.uploadFile(
            profilePic, '/farmers/', pictureName)
        : null;
    Map<String, dynamic> uppdate = {"picture": imageUrl};
    if (imageUrl != null) {
      docSnapshot = await DatabaseServices.updateDocument(
        'Farmers',
        docSnapshot.id,
        uppdate,
      );
    }
    farmer.picture = imageUrl;
    return 'saved';
  } else {
    return 'Phone Number Already Exists';
  }
}

updateFarmer(DocumentSnapshot farmerDocSnap,
    {Farmer farmer, var profilePic, String pictureName}) async {
  Farmer _existingfarmer = Farmer.fromMapObject(farmerDocSnap.data());

  var snaps;
  if (_existingfarmer.phone != farmer.phone) {
    snaps = await DatabaseServices.queryFromDatabaseByField(
        'Farmers', 'phone', farmer.phone);
  }
  if (snaps == null || snaps.docs.isNotEmpty) {
    DocumentReference docSnapshot = await DatabaseServices.setDocument(
      'Farmers',
      farmerDocSnap.id,
      farmer.toMap(),
    );

    var imageUrl = (profilePic != null)
        ? await DatabaseServices.uploadFile(
            profilePic, '/farmers/', pictureName)
        : null;
    Map<String, dynamic> uppdate = {"picture": imageUrl};
    if (imageUrl != null) {
      docSnapshot = await DatabaseServices.updateDocument(
        'Farmers',
        docSnapshot.id,
        uppdate,
      );
    }
    return 'saved';
  } else {
    return 'Phone Number Already Exists';
  }
  // farmer.picture = imageUrl;
}

deleteFarmer(String farmerId) async {
  await DatabaseServices.deleteDocument('Farmers', farmerId);
}
