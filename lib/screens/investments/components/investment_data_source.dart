import 'package:farmasyst_admin_console/components/circular_image.dart';
import 'package:farmasyst_admin_console/components/custom_alert_dailog.dart';
import 'package:farmasyst_admin_console/components/custom_switch.dart';
import 'package:farmasyst_admin_console/components/popup_button.dart';
import 'package:farmasyst_admin_console/models/investment.dart';
import 'package:farmasyst_admin_console/models/investment.dart';
import 'package:farmasyst_admin_console/models/supervisor.dart';
import 'package:farmasyst_admin_console/notifiers/farmers_state.dart';
import 'package:farmasyst_admin_console/notifiers/supervisors_state%20.dart';
import 'package:farmasyst_admin_console/screens/farms/components/farms_module.dart';
import 'package:farmasyst_admin_console/screens/farms/update_farm.dart';
import 'package:farmasyst_admin_console/screens/farms/view_farm.dart';
import 'package:farmasyst_admin_console/screens/investments/components/investment_module.dart';
import 'package:farmasyst_admin_console/screens/investments/view_investment.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvestmentsDataSource extends DataTableSource {
  List asyncSnapshot;
  BuildContext context;
  // Constructor
  InvestmentsDataSource(this.asyncSnapshot, this.context);

  // Start Overides
  @override
  DataRow getRow(int index) {
    var docSnapshot = asyncSnapshot[index];
    Investment investment = Investment.fromMapObject(docSnapshot.data());
    bool selected = false;
    return DataRow.byIndex(
      selected: selected,
      index: index,
      cells: <DataCell>[
        DataCell(Align(
          child: investment.farm['pictures'] != null
              ? CircularImage(
                  child: Image.network(investment.farm['pictures'][0]),
                )
              : CircularImage(
                  child: null,
                ),
          alignment: Alignment.center,
        )),
        DataCell(Text(investment.id.toString())),
        DataCell(Text(investment.farm['farmId'])),
        // todo: chnage name to id
        DataCell(Text(investment.farmer['name'])),
        DataCell(Text(investment.inverstor['name'])),
        // DataCell(Text(investment.id.toString())),
        // DataCell(Text(investment.farm['id'])),
        // // todo: chnage name to id
        // DataCell(Text(investment.farmer['name'])),
        // DataCell(Text(investment.inverstor['name'])),
        DataCell(
          CustomSwitch(
            isSwitched: investment.approved,
            onChanged: (value) async {
              Map<String, dynamic> update = {'approved': value};
              await DatabaseServices.updateDocument(
                'Investments',
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
                      return ViewInvestment(
                        investment: investment,
                        farmId: docSnapshot.id,
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
                      // return UpdateInvestment(
                      //   investment: investment,
                      //   farmDocSnap: docSnapshot,
                      // );
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
                              deleteInvestment(docSnapshot.id);
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
