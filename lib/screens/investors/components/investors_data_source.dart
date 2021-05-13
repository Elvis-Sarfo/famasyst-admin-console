import 'package:farmasyst_admin_console/components/circular_image.dart';
import 'package:farmasyst_admin_console/components/custom_alert_dailog.dart';
import 'package:farmasyst_admin_console/components/custom_switch.dart';
import 'package:farmasyst_admin_console/models/investor.dart';
import 'package:farmasyst_admin_console/screens/investors/components/investors_module.dart';
import 'package:farmasyst_admin_console/screens/investors/update_investor.dart';
import 'package:farmasyst_admin_console/screens/investors/view_investor.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';
import 'package:flutter/material.dart';

class InvestorDataSource extends DataTableSource {
  List asyncSnapshot;
  BuildContext context;
  // Constructor
  InvestorDataSource(this.asyncSnapshot, this.context);

  // Start Overides
  @override
  DataRow getRow(int index) {
    var docSnapshot = asyncSnapshot[index];
    Investor investor = Investor.fromMapObject(docSnapshot.data());
    bool selected = false;
    return DataRow.byIndex(
      selected: selected,
      // onSelectChanged: (value) {
      //   selected = value;
      //   // showDialog(
      //   //   context: context,
      //   //   builder: (BuildContext context) {
      //   //     return ViewInvestor(
      //   //       investor: investor,
      //   //       investorId: docSnapshot.id,
      //   //     );
      //   //   },
      //   // );
      // },
      index: index,
      cells: <DataCell>[
        // DataCell(Image.network(investor.picture)),
        DataCell(Align(
          child: investor.picture != null
              ? CircularImage(
                  child: Image.network(investor.picture),
                )
              : CircularImage(
                  child: null,
                ),
          alignment: Alignment.center,
        )),
        DataCell(Text(investor.name)),
        DataCell(Text(investor.type.toUpperCase() ?? '')),
        DataCell(Text(investor.phone)),
        DataCell(Text(investor.location)),
        DataCell(
          CustomSwitch(
            isSwitched: investor.enabled,
            onChanged: (value) async {
              Map<String, dynamic> update = {'enabled': value};
              await DatabaseServices.updateDocument(
                'Investors',
                docSnapshot.id,
                update,
              );
            },
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.remove_red_eye,
                  color: kPrimaryColor,
                ),
                tooltip: 'View',
                splashRadius: 20,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ViewInvestor(
                        investor: investor,
                        investorId: docSnapshot.id,
                      );
                    },
                  );
                },
              ),
              IconButton(
                splashRadius: 20,
                icon: const Icon(
                  Icons.edit,
                  color: kSecondaryColor,
                ),
                tooltip: 'Edit',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return UpdateInvestor(
                        investor: investor,
                        investorDocSnap: docSnapshot,
                      );
                    },
                  );
                },
              ),
              IconButton(
                splashRadius: 20,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                tooltip: 'Delete',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        title: 'Are you sure you want to delete?',
                        descriptions: 'This action cannot be undone!',
                        dialogIcon: Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 70,
                        ),
                        actionsButtons: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            onPressed: () {
                              deleteInvestor(docSnapshot.id);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Delete',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  kPrimaryColor),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => asyncSnapshot.length;

  @override
  int get selectedRowCount => 0;
}
