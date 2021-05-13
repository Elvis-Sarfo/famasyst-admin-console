// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/models/investment.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';

// Future<String> saveNewInvestment(Investment investment,
//     {var profilePic, String pictureName}) async {
//   // Get investment sequence counter from the db meta data
//   var databaseSchema = await DatabaseServices.querySingleUserById(
//       'counters', 'database_meta_data');

//   if (databaseSchema.exists) {
//     // Add one to the counter and assign to the investmentIdfilled of the new investment
//     var counter = ++databaseSchema.data()['investments_counter'];
//     investment.investmentId = 'FRM' + counter.toString();
//     DocumentReference docSnapshot =
//         await DatabaseServices.setDocument('Investments', investment.investmentId, investment.toMap());

//     // Upload image if there is any
//     var imageUrl = (profilePic != null)
//         ? await DatabaseServices.uploadFile(
//             profilePic, '/investments/', investment.investmentId.toString())
//         : null;

//     // Update the images list of the investment
//     if (imageUrl != null) {
//       Map<String, dynamic> uppdate = {
//         "pictures": [imageUrl]
//       };
//       docSnapshot = await DatabaseServices.updateDocument(
//         'Investments',
//         docSnapshot.id,
//         uppdate,
//       );
//       investment.pictures.add(imageUrl);
//     }

//     // Update the investmenter counter
//     Map<String, dynamic> counterUpdate = {'investments_counter': investment.investmentId};
//     await DatabaseServices.updateDocument(
//       'database_meta_data',
//       'counters',
//       counterUpdate,
//     );
//     return 'saved';
//   } else {
//     return 'Error';
//   }
// }

// updateInvestment(DocumentSnapshot investmentDocSnap,
//     {Investment investment, var profilePic, String pictureName}) async {
//   // Investment _existinginvestment = Investment.fromMapObject(investmentDocSnap.data());

//   DocumentReference docSnapshot = await DatabaseServices.setDocument(
//     'Investments',
//     investmentDocSnap.id,
//     investment.toMap(),
//   );

//   // Upload image if there is any
//   var imageUrl = (profilePic != null)
//       ? await DatabaseServices.uploadFile(
//           profilePic, '/investments/', investment.investmentId.toString())
//       : null;

//   // Update the images list of the investment
//   if (imageUrl != null) {
//     Map<String, dynamic> uppdate = {
//       "pictures": [imageUrl]
//     };
//     docSnapshot = await DatabaseServices.updateDocument(
//       'Investments',
//       investmentDocSnap.id,
//       uppdate,
//     );
//     investment.pictures.add(imageUrl);
//   }
//   return 'saved';
// }

deleteInvestment(String investmentId) async {
  await DatabaseServices.deleteDocument('Investments', investmentId);
}

assignInvestmentToSupervisor(String investmentId, dynamic update) async {
  Map<String, dynamic> _update = {'supervisor': update};
  await DatabaseServices.updateDocument(
    'Investments',
    investmentId,
    _update,
  );
}
