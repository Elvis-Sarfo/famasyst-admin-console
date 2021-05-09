// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/models/farm.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';

Future<String> saveNewFarm(Farm farm,
    {var profilePic, String pictureName}) async {
  // var docs = await DatabaseServices.queryFromDatabaseByField(
  //     'Farms', 'phone', farm.phone);
  // if (docs.docs.isEmpty) {
  //   DocumentReference docSnapshot =
  //       await DatabaseServices.saveData('Farms', farm.toMap());

  //   var imageUrl = (profilePic != null)
  //       ? await DatabaseServices.uploadFile(
  //           profilePic, '/farms/', pictureName)
  //       : null;
  //   Map<String, dynamic> uppdate = {"picture": imageUrl};
  //   if (imageUrl != null) {
  //     docSnapshot = await DatabaseServices.updateDocument(
  //       'Farms',
  //       docSnapshot.id,
  //       uppdate,
  //     );
  //   }
  //   farm.pictures = imageUrl;
  //   return 'saved';
  // } else {
  //   return 'Phone Number Already Exists';
  // }
}

updateFarm(DocumentSnapshot farmDocSnap,
    {Farm farm, var profilePic, String pictureName}) async {
  // Farm _existingfarm = Farm.fromMapObject(farmDocSnap.data());

  // var snaps;
  // if (_existingfarm.phone != farm.phone) {
  //   snaps = await DatabaseServices.queryFromDatabaseByField(
  //       'Farms', 'phone', farm.phone);
  // }
  // if (snaps == null || snaps.docs.isNotEmpty) {
  //   DocumentReference docSnapshot = await DatabaseServices.setDocument(
  //     'Farms',
  //     farmDocSnap.id,
  //     farm.toMap(),
  //   );

  //   var imageUrl = (profilePic != null)
  //       ? await DatabaseServices.uploadFile(profilePic, '/farms/', pictureName)
  //       : null;
  //   Map<String, dynamic> uppdate = {"picture": imageUrl};
  //   if (imageUrl != null) {
  //     docSnapshot = await DatabaseServices.updateDocument(
  //       'Farms',
  //       farmDocSnap.id,
  //       uppdate,
  //     );
  //   }
  //   return 'saved';
  // } else {
  //   return 'Phone Number Already Exists';
  // }
  // farm.picture = imageUrl;
}

deleteFarm(String farmId) async {
  await DatabaseServices.deleteDocument('Farms', farmId);
}
