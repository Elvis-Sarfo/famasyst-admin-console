// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/models/supervisor.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';

Future<String> saveNewSupervisor(Supervisor supervisor,
    {var profilePic, String pictureName}) async {
  var docs = await DatabaseServices.queryFromDatabaseByField(
      'Supervisors', 'phone', supervisor.phone);
  if (docs.docs.isEmpty) {
    DocumentReference docSnapshot =
        await DatabaseServices.saveData('Supervisors', supervisor.toMap());

    var imageUrl = (profilePic != null)
        ? await DatabaseServices.uploadFile(
            profilePic, '/supervisors/', pictureName)
        : null;
    Map<String, dynamic> uppdate = {"picture": imageUrl};
    if (imageUrl != null) {
      docSnapshot = await DatabaseServices.updateDocument(
        'Supervisors',
        docSnapshot.id,
        uppdate,
      );
    }
    supervisor.picture = imageUrl;
    return 'saved';
  } else {
    return 'Phone Number Already Exists';
  }
}

updateSupervisor(DocumentSnapshot supervisorDocSnap,
    {Supervisor supervisor, var profilePic, String pictureName}) async {
  Supervisor _existingsupervisor =
      Supervisor.fromMapObject(supervisorDocSnap.data());

  var snaps;
  if (_existingsupervisor.phone != supervisor.phone) {
    snaps = await DatabaseServices.queryFromDatabaseByField(
        'Supervisors', 'phone', supervisor.phone);
  }
  if (snaps == null || snaps.docs.isNotEmpty) {
    DocumentReference docSnapshot = await DatabaseServices.setDocument(
      'Supervisors',
      supervisorDocSnap.id,
      supervisor.toMap(),
    );

    var imageUrl = (profilePic != null)
        ? await DatabaseServices.uploadFile(
            profilePic, '/supervisors/', pictureName)
        : null;
    Map<String, dynamic> uppdate = {"picture": imageUrl};
    if (imageUrl != null) {
      docSnapshot = await DatabaseServices.updateDocument(
        'Supervisors',
        supervisorDocSnap.id,
        uppdate,
      );
    }
    return 'saved';
  } else {
    return 'Phone Number Already Exists';
  }
  // supervisor.picture = imageUrl;
}

deleteSupervisor(String supervisorId) async {
  await DatabaseServices.deleteDocument('Supervisors', supervisorId);
}
