import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class PageRouter extends ChangeNotifier {
  Widget _selectedPage = Container(
    child: Center(
      child: Text('Hello Kanta'),
    ),
  );

  Widget get selectedPage => _selectedPage;

  route(Widget page) {
    _selectedPage = page;
    notifyListeners();
  }
}
