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
    var counter = ++databaseSchema.data()['farms_counter'];
    farm.farmId = 'FRM' + counter.toString();
    DocumentReference docSnapshot =
        await DatabaseServices.setDocument('Farms', farm.farmId, farm.toMap());

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
    Map<String, dynamic> counterUpdate = {'farms_counter': counter};
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
  // Farm _existingfarm = Farm.fromMapObject(farmDocSnap.data());

  DocumentReference docSnapshot = await DatabaseServices.setDocument(
    'Farms',
    farmDocSnap.id,
    farm.toMap(),
  );

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

assignFarmToSupervisor(String farmId, dynamic update) async {
  Map<String, dynamic> _update = {'supervisor': update};
  await DatabaseServices.updateDocument(
    'Farms',
    farmId,
    _update,
  );
}
