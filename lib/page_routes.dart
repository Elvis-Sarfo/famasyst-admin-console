import 'package:farmasyst_admin_console/components/image_chooser.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class PageRouter extends ChangeNotifier {
  Widget _selectedPage = Container(
    child: Center(
      // child: Text('KantaTech'),
      child: ImageChooser(),
    ),
  );

  Widget get selectedPage => _selectedPage;

  route(Widget page) {
    _selectedPage = page;
    notifyListeners();
  }
}
