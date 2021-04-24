// import 'dart:io';
import 'dart:html' as html;
import 'dart:io';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
// import 'package:image_picker_web/image_picker_web.dart';

class ImageChooser extends StatefulWidget {
  ImageChooser({Key key}) : super(key: key);

  @override
  _ImageChooserState createState() => _ImageChooserState();
}

class _ImageChooserState extends State<ImageChooser> {
  // final picker = ImagePicker();

  File image;
  File _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () {
            _showPicker(context);
          },
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
            child: image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(
                      image,
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(50)),
                    width: 150,
                    height: 150,
                    child: Stack(children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black38,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, bottom: 25),
                          child: Text(
                            'Take photo',
                            style: TextStyle(color: kPrimaryDark),
                          ),
                        ),
                      )
                    ]),
                  ),
          ),
        ),
      ),
    );
  }

  Future _showPicker(context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext bc) {
        return AlertDialog(
          content: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Photo Library'),
                  onTap: getImageFromGallery,
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    // getImageFromCamera();
                    setState(() {
                      getImageFromCamera();
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getImageFromGallery() async {
    // final pickedFile = await picker.getImage(source: ImageSource.gallery);
    html.File pickedFile =
        await ImagePickerWeb.getImage(outputType: ImageType.file);
    print(pickedFile);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.relativePath);
      });
    } else {
      print('No _image selected.');
    }
  }

  Future<void> getImageFromCamera() async {
    // final pickedFile = await picker.getImage(source: ImageSource.camera);

    // if (pickedFile != null) {
    //   setState(() {
    //     _image = File(pickedFile.path);
    //   });
    // } else {
    //   print('No _image selected.');
    // }
  }
}

// Widget imageChooser() {
//   return Center(
//     child: GestureDetector(
//       onTap: () {
//         _showPicker(context);
//       },
//       child: CircleAvatar(
//         radius: 70,
//         backgroundColor: Colors.white,
//         child: _image != null
//             ? ClipRRect(
//                 borderRadius: BorderRadius.circular(100),
//                 child: Image.file(
//                   _image,
//                   width: 150,
//                   height: 150,
//                   fit: BoxFit.fill,
//                 ),
//               )
//             : Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white24,
//                     borderRadius: BorderRadius.circular(50)),
//                 width: 150,
//                 height: 150,
//                 child: Stack(children: <Widget>[
//                   Align(
//                     alignment: Alignment.center,
//                     child: Icon(
//                       Icons.camera_alt,
//                       color: Colors.black38,
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           left: 8.0, right: 8, bottom: 25),
//                       child: Text(
//                         'Take photo',
//                         style: TextStyle(color: primaryDark),
//                       ),
//                     ),
//                   )
//                 ]),
//               ),
//       ),
//     ),
//   );
// }
