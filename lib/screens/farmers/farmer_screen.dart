import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/components/main_button.dart';
import 'package:farmasyst_admin_console/models/farmer.dart';
import 'package:farmasyst_admin_console/screens/farmers/add_new_farmer.dart';
import 'package:farmasyst_admin_console/screens/farmers/components/dts.dart';
import 'package:farmasyst_admin_console/notifiers/farmers_state.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:provider/provider.dart';

class FarmerScreen extends StatelessWidget {
  // CollectionReference farmers =
  //     FirebaseFirestore.instance.collection('Farmers');
  // var farmerStream =
  //     FirebaseFirestore.instance.collection('Farmers').snapshots();
  // List<DocumentSnapshot> farmersList, filteredFarmersList;
  // FarmersState pageState = FarmersState();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // CollectionReference farmers =
    //
    Function _searchFarmer;
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
                  onChanged: (value) async {
                    _searchFarmer(value);
                  },
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
            child:
                Consumer<FarmersState>(builder: (context, farmersState, child) {
              // Assing the searchHandler to a upper scope
              _searchFarmer = farmersState.searchFarmer;

              if (farmersState.hasError) {
                return Center(child: Text('Something went wrong'));
              }
              if (farmersState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SingleChildScrollView(
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
                    source: DTS(farmersState.getFilteredFarmers, context),
                  ),
                ),
              );
            }),

            //
            // StreamBuilder<QuerySnapshot>(
            //   stream: farmerStream,
            //   builder: (
            //     BuildContext context,
            //     AsyncSnapshot<QuerySnapshot> snapshot,
            //   ) {
            //     List _farmersList = [];
            //     if (snapshot.hasError) {
            //       return Center(child: Text('Something went wrong'));
            //     }

            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       // return Center(child: Text("Loading..."));
            //       return Center(
            //         child: CircularProgressIndicator(
            //             // backgroundColor: Colors.lightBlueAccent,
            //             ),
            //       );
            //     }

            //     if (snapshot.connectionState == ConnectionState.done &&
            //         !snapshot.hasData) {
            //       return Center(
            //         child: Text('No Farmers found'),
            //       );
            //     }
            //     // Populate the data in the farmersList
            //     // farmersData = snapshot.data.docs.toList();
            //     // if (snapshot.hasData) {
            //     //   filteredFarmersList = snapshot.data.docs.toList();
            //     //   farmersList = filteredFarmersList;
            //     // }
            //     print('object');
            //     if (snapshot.data.docChanges.isNotEmpty) {
            //       filteredFarmersList = snapshot.data.docs.toList();
            //       farmersList = filteredFarmersList;
            //       print('qqqqqqqqqqqqqqqqq');
            //     }

            //     if (snapshot.data.docChanges.isEmpty) {
            //       filteredFarmersList = snapshot.data.docs.toList();
            //       farmersList = [];
            //       print('wwwwwwwwwwwwwwwwwwwwwwwwww');
            //     }

            //     return SingleChildScrollView(
            //       child: Container(
            //         width: size.width,
            //         child: PaginatedDataTable(
            //           rowsPerPage: 7,
            //           sortAscending: true,
            //           sortColumnIndex: 1,
            //           columns: const <DataColumn>[
            //             DataColumn(label: Text('')),
            //             DataColumn(label: Text('Name')),
            //             DataColumn(label: Text('Phone')),
            //             DataColumn(label: Text('Location')),
            //             DataColumn(label: Text('Gender')),
            //             DataColumn(label: Text('Enabled')),
            //             DataColumn(
            //                 label: Text(
            //               'Actions',
            //               textAlign: TextAlign.center,
            //             )),
            //           ],
            //           source: DTS(filteredFarmersList, context),
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ),
        ],
      ),
    );
  }

  Widget sdsd(BuildContext context, Widget h) {
    return SingleChildScrollView(
      child: Container(
        // width: size.width,
        child: Consumer<FarmersState>(
          builder: (context, farmersState, child) {
            farmersState.startStreaming();
            return PaginatedDataTable(
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
              source: DTS(farmersState.getFilteredFarmers, context),
            );
          },
        ),
      ),
    );
  }
}
