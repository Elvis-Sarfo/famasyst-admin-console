// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/models/supervisor.dart';
import 'package:farmasyst_admin_console/services/auth_services.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> saveNewSupervisor(Supervisor supervisor,
    {var profilePic, String pictureName}) async {
  var docs = await DatabaseServices.queryFromDatabaseByField(
      'Supervisors', 'phone', supervisor.phone);

  var userCredentials = await Auth.signUpWithEmailandPassword(
    email: supervisor.email,
    password: '123456',
  );

  if (docs.docs.isEmpty && (userCredentials is UserCredential)) {
    await DatabaseServices.setDocument(
        'Supervisors', userCredentials.user.uid, supervisor.toMap());

    var imageUrl = (profilePic != null)
        ? await DatabaseServices.uploadFile(
            profilePic, '/supervisors/', pictureName)
        : null;
    Map<String, dynamic> uppdate = {"picture": imageUrl};
    if (imageUrl != null) {
      await DatabaseServices.updateDocument(
        'Supervisors',
        userCredentials.user.uid,
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

    if (imageUrl != null) {
      Map<String, dynamic> uppdate = {"picture": imageUrl};
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
