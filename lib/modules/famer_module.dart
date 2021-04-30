import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/data_models/farmer.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';

saveNewFarmer(Farmer farmer, {var profilePic, String pictureName}) async {
  DocumentReference docSnapshot =
      await DatabaseServices.saveData('Farmers', farmer.toMap());

  var imageUrl = (profilePic != null)
      ? await DatabaseServices.uploadFile(profilePic, '/farmers/', pictureName)
      : null;
  Map<String, dynamic> uppdate = {"picture": imageUrl};
  if (imageUrl != null) {
    docSnapshot = await DatabaseServices.setDocument(
      'Farmers',
      docSnapshot.id,
      uppdate,
    );
  }
  // farmer.picture = imageUrl;
}
