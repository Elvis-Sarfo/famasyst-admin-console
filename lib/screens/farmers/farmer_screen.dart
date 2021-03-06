import 'package:farmasyst_admin_console/components/main_button.dart';
import 'package:farmasyst_admin_console/screens/farmers/add_new_farmer.dart';
import 'package:farmasyst_admin_console/screens/farmers/components/farmers_data_source.dart';
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
  // int _columnIndex = 1;
  // bool _ascending = true;
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
                    fillColor: Colors.white,
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
                    onSelectAll: (b) {},
                    rowsPerPage: 7,
                    horizontalMargin: 5,
                    columnSpacing: 5,
                    sortAscending: farmersState.sortAscending,
                    sortColumnIndex: farmersState.sortColumnIndex,
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text(''),
                      ),
                      DataColumn(
                        label: Text('Name'),
                        onSort: (index, sorted) {
                          farmersState.sortFarmerList('name', index, sorted);
                        },
                      ),
                      DataColumn(
                        label: Text('Phone'),
                        onSort: (index, sorted) {
                          farmersState.sortFarmerList('phone', index, sorted);
                        },
                      ),
                      DataColumn(
                        label: Text('Location'),
                        onSort: (index, sorted) {
                          farmersState.sortFarmerList(
                              'location', index, sorted);
                        },
                      ),
                      DataColumn(
                        label: Text('Gender'),
                        onSort: (index, sorted) {
                          farmersState.sortFarmerList('gender', index, sorted);
                        },
                      ),
                      DataColumn(label: Text('Enabled')),
                      DataColumn(
                          label: Text(
                        'Actions',
                        textAlign: TextAlign.center,
                      )),
                    ],
                    source: FarmerDataSource(
                        farmersState.getFilteredFarmers, context),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class Episode5 extends StatefulWidget {
  @override
  Episode5State createState() {
    return new Episode5State();
  }
}

class Episode5State extends State<Episode5> {
  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 1,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("First Name"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.firstName.compareTo(b.firstName));
            });
          },
          tooltip: "To display first name of the Name",
        ),
        DataColumn(
          label: Text("Last Name"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.lastName.compareTo(b.lastName));
            });
          },
          tooltip: "To display last name of the Name",
        ),
      ],
      rows: names
          .map(
            (name) => DataRow(
              cells: [
                DataCell(
                  Text(name.firstName),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(name.lastName),
                  showEditIcon: false,
                  placeholder: false,
                )
              ],
            ),
          )
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Episode 5 - Data Table"),
      ),
      body: Container(
        child: bodyData(),
      ),
    );
  }
}

class Name {
  String firstName;
  String lastName;

  Name({this.firstName, this.lastName});
}

var names = <Name>[
  Name(firstName: "Pawan", lastName: "Kumar"),
  Name(firstName: "Aakash", lastName: "Tewari"),
  Name(firstName: "Rohan", lastName: "Singh"),
];
