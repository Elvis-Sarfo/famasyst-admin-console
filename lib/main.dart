import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:farmasyst_admin_console/components/frame_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmasyst Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF399d63,
          const <int, Color>{
            50: const Color(0xFF6dcf91),
            100: const Color(0xFF6dcf91),
            200: const Color(0xFF6dcf91),
            300: const Color(0xFF399d63),
            400: const Color(0xFF399d63),
            500: const Color(0xFF399d63),
            600: const Color(0xFF399d63),
            700: const Color(0xFF006e38),
            800: const Color(0xFF006e38),
            900: const Color(0xFF006e38),
          },
        ),
        primaryColorDark: kPrimaryDark,
        primaryColor: kPrimaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: FrameContainer(),
      // home: Text('Hello World'),
    );
  }
}

// import 'dart:html' as html;

// import 'package:flutter/material.dart';
// import 'package:image_picker_web/image_picker_web.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final _pickedImages = <Image>[];
//   final _pickedVideos = <dynamic>[];

//   String _imageInfo = '';

//   Future<void> _pickImage() async {
//     Image fromPicker =
//         await ImagePickerWeb.getImage(outputType: ImageType.widget);

//     if (fromPicker != null) {
//       setState(() {
//         _pickedImages.clear();
//         _pickedImages.add(fromPicker);
//       });
//     }
//   }

//   Future<void> _pickVideo() async {
//     final videoMetaData =
//         await ImagePickerWeb.getVideo(outputType: VideoType.bytes);
//     if (videoMetaData != null)
//       setState(() {
//         _pickedVideos.clear();
//         _pickedVideos.add(videoMetaData);
//       });
//   }

//   Future<void> _pickMultiImages() async {
//     List<Image> images =
//         await ImagePickerWeb.getMultiImages(outputType: ImageType.widget);
//     setState(() {
//       _pickedImages.clear();
//       _pickedImages.addAll(images);
//     });
//   }

//   Future<void> _getImgFile() async {
//     html.File infos = await ImagePickerWeb.getImage(outputType: ImageType.file);
//     setState(() => _imageInfo =
//         'Name: ${infos.name}\nRelative Path: ${infos.relativePath}');
//   }

//   Future<void> _getImgInfo() async {
//     final infos = await ImagePickerWeb.getImageInfo;
//     setState(() {
//       _pickedImages.clear();
//       _pickedImages.add(Image.memory(
//         infos.data,
//         semanticLabel: infos.fileName,
//       ));
//       _imageInfo = '${infos.toJson()}';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Image Picker Web Example'),
//         ),
//         body: Center(
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//               Wrap(
//                 // spacing: 15.0,
//                 children: <Widget>[
//                   AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 300),
//                     switchInCurve: Curves.easeIn,
//                     child: SizedBox(
//                       width: 500,
//                       height: 200,
//                       child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount:
//                               _pickedImages == null ? 0 : _pickedImages.length,
//                           itemBuilder: (context, index) =>
//                               _pickedImages[index]),
//                     ),
//                   ),
//                   Container(
//                     height: 200,
//                     width: 200,
//                     child: Text(_imageInfo, overflow: TextOverflow.ellipsis),
//                   ),
//                   ..._pickedVideos
//                       .map<Widget>((e) => Text(
//                             e.toString(),
//                             overflow: TextOverflow.ellipsis,
//                           ))
//                       .toList(),
//                 ],
//               ),
//               ButtonBar(alignment: MainAxisAlignment.center, children: <Widget>[
//                 ElevatedButton(
//                   onPressed: _pickImage,
//                   child: const Text('Select Image'),
//                 ),
//                 ElevatedButton(
//                   onPressed: _pickVideo,
//                   child: const Text('Select Video'),
//                 ),
//                 ElevatedButton(
//                   onPressed: _pickMultiImages,
//                   child: const Text('Select Multi Images'),
//                 ),
//                 ElevatedButton(
//                   onPressed: _getImgFile,
//                   child: const Text('Get Image File'),
//                 ),
//                 ElevatedButton(
//                   onPressed: _getImgInfo,
//                   child: const Text('Get Image Info'),
//                 ),
//               ]),
//             ])),
//       ),
//     );
//   }
// }
