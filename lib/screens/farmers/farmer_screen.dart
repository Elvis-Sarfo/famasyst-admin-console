import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/components/main_button.dart';
import 'package:farmasyst_admin_console/screens/farmers/add_new_farmer.dart';
import 'package:farmasyst_admin_console/screens/farmers/components/dts.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/services/constants.dart';

class FarmerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference farmers =
        FirebaseFirestore.instance.collection('Farmers');

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
                      return AddNewFarmerDialog();
                    },
                  );
                },
              ),
            ],
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: farmers.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("Loading..."));
              }

              return new SingleChildScrollView(
                child: Container(
                  width: size.width,
                  child: PaginatedDataTable(
                    rowsPerPage: 7,
                    sortAscending: true,
                    sortColumnIndex: 1,
                    columns: const <DataColumn>[
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Phone')),
                      DataColumn(label: Text('Location')),
                      DataColumn(label: Text('Gender')),
                      DataColumn(label: Text('Enabled')),
                      DataColumn(
                          label: Text(
                        'Actions',
                        textAlign: TextAlign.center,
                      )),
                    ],
                    source: DTS(snapshot, context),
                  ),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
