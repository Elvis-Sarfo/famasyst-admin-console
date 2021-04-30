import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void sendToPage(BuildContext context, Widget newPage) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (BuildContext context) => newPage),
  );
}

void noReturnSendToPage(BuildContext context, Widget newPage) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => newPage),
      (route) => false);
}

Future<void> showSnackBar(String message, ScaffoldState state) async {
  final _snackBar = SnackBar(
    content: Text(
      message.toString(),
      textAlign: TextAlign.center,
    ),
    duration: Duration(milliseconds: 4000),
  );
  state.showSnackBar(_snackBar);
  await Future.delayed(Duration(seconds: 1));
}

// String encryptString(String data) {
//   // Key generator
//   var keyGen = CryptKey();
//   //generate 32 byte key using Fortuna
//   var key32 = keyGen.genFortuna(len: 32);
//   var iv16 = keyGen.genDart(len: 16);
//   // generated AES encrypter with key + padding
//   var aes = AesCrypt(key: key32, padding: PaddingAES.pkcs7);

//   var crypted = aes.gcm.encrypt(inp: data, iv: iv16); //encrypt
//   return crypted;
// }

// String decryptString(String data) {
//   // Key generator
//   var keyGen = CryptKey();
//   //generate 32 byte key using Fortuna
//   var key32 = keyGen.genFortuna(len: 32);
//   var iv16 = keyGen.genDart(len: 16);
//   // generated AES encrypter with key + padding
//   var aes = AesCrypt(key: key32, padding: PaddingAES.pkcs7);

//   var planeText = aes.gcm.decrypt(enc: data, iv: iv16); //encrypt
//   return planeText;
// }

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load(path);
  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  return file;
}

int getYears(DateTime date) {
  Duration dur = DateTime.now().difference(date);
  int differenceInYears = (dur.inDays / 365).floor();
  return differenceInYears;
}
