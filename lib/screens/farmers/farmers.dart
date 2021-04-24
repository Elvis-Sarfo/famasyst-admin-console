import 'package:farmasyst_admin_console/components/cus_text_form_field.dart';
import 'package:farmasyst_admin_console/components/main_button.dart';
import 'package:farmasyst_admin_console/responsive.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/services/constants.dart';

class FarmerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.fromLTRB(100, 10, 100, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  'Farmers',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: kPrimaryDark),
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                width: size.width * 0.25,
                height: 46,
                child: TextFormField(
                  maxLines: 1,
                  minLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: IconButton(
                      padding: EdgeInsets.all(0),
                      iconSize: 26,
                      splashRadius: 20,
                      highlightColor: kPrimaryColor.withOpacity(0.3),
                      hoverColor: kPrimaryColor.withOpacity(0.3),
                      icon: Icon(
                        Icons.search,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {},
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Enter a search term',
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              MainButton(
                color: kPrimaryColor,
                title: 'Add New Farmer',
                iconData: Icons.person_add,
                tapEvent: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _buildNewFarmerDialog(context, size);
                    },
                  );
                },
              ),

              // TextField(
              //   decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       hintText: 'Enter a search term'),
              // ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: size.width,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Name',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Age',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Role',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Role',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Role',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Role',
                      ),
                    ),
                  ],
                  rows: List.generate(
                    10,
                    (index) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Sarah')),
                        DataCell(Text('19')),
                        DataCell(Text('Student')),
                        DataCell(Text('Student')),
                        DataCell(Text('Student')),
                        DataCell(Text('Student')),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // build a form widget
  Widget _buildNewFarmerDialog(BuildContext context, Size size) {
    return AlertDialog(
      content: Container(
        width: size.width * 0.7,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Register Farmer',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                Tooltip(
                  message: "Close Window",
                  child: IconButton(
                      splashColor: Colors.red.withOpacity(0.3),
                      hoverColor: Colors.red.withOpacity(0.3),
                      splashRadius: 20,
                      highlightColor: Colors.white,
                      icon: Icon(
                        Icons.close,
                        color: Colors.redAccent,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                )
              ],
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: !isMobile(context) ? 40 : 0),
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (isMobile(context))
                              Image.asset(
                                'assets/images/main.png',
                                height: size.height * 0.3,
                              ),
                            CustomTextFormField(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Enter Full Name',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Enter Full Name',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Enter Full Name',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Enter Full Name',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Enter Full Name',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Enter Full Name',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Enter Full Name',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Enter Full Name',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Wrap(
                              runSpacing: 10,
                              children: <Widget>[
                                MainButton(
                                  title: 'GET STARTED',
                                  color: kPrimaryColor,
                                  tapEvent: () {},
                                ),
                                SizedBox(width: 10),
                                MainButton(
                                  title: 'WATCH VIDEO',
                                  color: kSecondaryColor,
                                  tapEvent: () {},
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (isDesktop(context) || isTab(context))
                    Expanded(
                      child: Image.asset(
                        'assets/images/main.png',
                        height: size.height * 0.7,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
