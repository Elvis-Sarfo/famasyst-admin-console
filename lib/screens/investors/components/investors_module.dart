// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/models/investor.dart';
import 'package:farmasyst_admin_console/services/auth_services.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> saveNewInvestor(Investor investor,
    {var profilePic, String pictureName}) async {
  var docs = await DatabaseServices.queryFromDatabaseByField(
      'Investors', 'phone', investor.phone);

  // Create user in the auth users
  var userCredentials = await Auth.signUpWithEmailandPassword(
    email: investor.email,
    password: '123456',
  );

  // Save the user
  if (docs.docs.isEmpty && (userCredentials is UserCredential)) {
    DocumentReference docSnapshot =
        await DatabaseServices.saveData('Investors', investor.toMap());

    var imageUrl = (profilePic != null)
        ? await DatabaseServices.uploadFile(
            profilePic, '/investors/', pictureName)
        : null;
    Map<String, dynamic> uppdate = {"picture": imageUrl};
    if (imageUrl != null) {
      docSnapshot = await DatabaseServices.updateDocument(
        'Investors',
        docSnapshot.id,
        uppdate,
      );
    }
    investor.picture = imageUrl;
    return 'saved';
  } else {
    return 'Email or Phone Number Already Exists';
  }
}

updateInvestor(DocumentSnapshot investorDocSnap,
    {Investor investor, var profilePic, String pictureName}) async {
  Investor _existinginvestor = Investor.fromMapObject(investorDocSnap.data());

  var snaps;
  if (_existinginvestor.phone != investor.phone) {
    snaps = await DatabaseServices.queryFromDatabaseByField(
        'Investors', 'phone', investor.phone);
  }
  if (snaps == null || snaps.docs.isNotEmpty) {
    DocumentReference docSnapshot = await DatabaseServices.setDocument(
      'Investors',
      investorDocSnap.id,
      investor.toMap(),
    );

    var imageUrl = (profilePic != null)
        ? await DatabaseServices.uploadFile(
            profilePic, '/investors/', pictureName)
        : null;
    Map<String, dynamic> uppdate = {"picture": imageUrl};
    if (imageUrl != null) {
      docSnapshot = await DatabaseServices.updateDocument(
        'Investors',
        investorDocSnap.id,
        uppdate,
      );
    }
    return 'saved';
  } else {
    return 'Phone Number Already Exists';
  }
  // investor.picture = imageUrl;
}

deleteInvestor(String investorId) async {
  await DatabaseServices.deleteDocument('Investors', investorId);
}
