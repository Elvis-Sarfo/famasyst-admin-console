// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/models/farm.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';

Future<String> saveNewFarm(Farm farm,
    {var profilePic, String pictureName}) async {
  // Get farm sequence counter from the db meta data
  var databaseSchema = await DatabaseServices.querySingleUserById(
      'counters', 'database_meta_data');

  if (databaseSchema.exists) {
    // Add one to the counter and assign to the farmIdfilled of the new farm
    farm.farmId = ++databaseSchema.data()['farms_counter'];
    DocumentReference docSnapshot =
        await DatabaseServices.saveData('Farms', farm.toMap());

    // Upload image if there is any
    var imageUrl = (profilePic != null)
        ? await DatabaseServices.uploadFile(
            profilePic, '/farms/', farm.farmId.toString())
        : null;

    // Update the images list of the farm
    if (imageUrl != null) {
      Map<String, dynamic> uppdate = {
        "pictures": [imageUrl]
      };
      docSnapshot = await DatabaseServices.updateDocument(
        'Farms',
        docSnapshot.id,
        uppdate,
      );
      farm.pictures.add(imageUrl);
    }

    // Update the farmer counter
    Map<String, dynamic> counterUpdate = {'farms_counter': farm.farmId};
    await DatabaseServices.updateDocument(
      'database_meta_data',
      'counters',
      counterUpdate,
    );
    return 'saved';
  } else {
    return 'Error';
  }
}

updateFarm(DocumentSnapshot farmDocSnap,
    {Farm farm, var profilePic, String pictureName}) async {
  Farm _existingfarm = Farm.fromMapObject(farmDocSnap.data());

  DocumentReference docSnapshot = await DatabaseServices.setDocument(
    'Farms',
    farmDocSnap.id,
    farm.toMap(),
  );

  var imageUrl = (profilePic != null)
      ? await DatabaseServices.uploadFile(profilePic, '/farms/', pictureName)
      : null;

  if (imageUrl != null) {
    Map<String, dynamic> uppdate = {"picture": imageUrl};
    docSnapshot = await DatabaseServices.updateDocument(
      'Farms',
      farmDocSnap.id,
      uppdate,
    );
    farm.pictures.add(imageUrl);
  }
  return 'saved';
}

deleteFarm(String farmId) async {
  await DatabaseServices.deleteDocument('Farms', farmId);
}
