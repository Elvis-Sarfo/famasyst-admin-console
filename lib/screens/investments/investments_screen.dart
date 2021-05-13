import 'package:farmasyst_admin_console/components/main_button.dart';
import 'package:farmasyst_admin_console/notifiers/farms_state.dart';
import 'package:farmasyst_admin_console/notifiers/investments_state.dart';
import 'package:farmasyst_admin_console/screens/farms/add_new_farm.dart';
import 'package:farmasyst_admin_console/screens/farms/components/farms_data_source.dart';
import 'package:farmasyst_admin_console/screens/investments/components/investment_data_source.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:provider/provider.dart';

class InvestmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Function _searchInvestments;
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
                  'Investments',
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
                    _searchInvestments(value);
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
              // MainButton(
              //   color: kPrimaryColor,
              //   title: 'Add New Investment',
              //   iconData: Icons.person_add,
              //   tapEvent: () {
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         // return AddNewInvestmentDialog();
              //       },
              //     );
              //   },
              // ),
            ],
          ),
          Expanded(
            child: Consumer<InvestmentsState>(
              builder: (context, investmentState, child) {
                // Assing the searchHandler to a upper scope
                _searchInvestments = investmentState.searchInvestment;

                if (investmentState.hasError) {
                  return Center(child: Text('Something went wrong'));
                }
                if (investmentState.waiting) {
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
                      sortAscending: investmentState.sortAscending,
                      sortColumnIndex: investmentState.sortColumnIndex,
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text(''),
                        ),
                        DataColumn(
                          label: Text('Investment ID'),
                          onSort: (index, sorted) {
                            investmentState.sortInvestmentList(
                                'id', index, sorted);
                          },
                        ),
                        DataColumn(
                          label: Text('Farm'),
                          onSort: (index, sorted) {},
                        ),
                        DataColumn(
                          label: Text('Farmer'),
                          onSort: (index, sorted) {
                            investmentState.sortInvestmentList(
                                'farmSize', index, sorted);
                          },
                        ),
                        DataColumn(
                          label: Text('Investor'),
                          onSort: (index, sorted) {
                            investmentState.sortInvestmentList(
                                'location', index, sorted);
                          },
                        ),
                        DataColumn(
                          label: Text('Approved'),
                          onSort: (index, sorted) {},
                        ),
                        // DataColumn(label: Text('Enabled')),
                        DataColumn(
                            label: Text(
                          'Actions',
                          textAlign: TextAlign.center,
                        )),
                      ],
                      source: InvestmentsDataSource(
                          investmentState.getFilteredInvestments, context),
                    ),
                  ),
                );
              },
            ),
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
