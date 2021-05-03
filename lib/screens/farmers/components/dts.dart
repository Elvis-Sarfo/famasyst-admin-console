import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/components/custom_alert_dailog.dart';
import 'package:farmasyst_admin_console/components/custom_switch.dart';
import 'package:farmasyst_admin_console/data_models/farmer.dart';
import 'package:farmasyst_admin_console/modules/famer_module.dart';
import 'package:farmasyst_admin_console/screens/farmers/update_farmer.dart';
import 'package:farmasyst_admin_console/screens/farmers/view_farmer.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';
import 'package:farmasyst_admin_console/utils/helper_functions.dart';
import 'package:flutter/material.dart';

class DTS extends DataTableSource {
  AsyncSnapshot<QuerySnapshot> asyncSnapshot;
  BuildContext context;
  // Constructor
  DTS(this.asyncSnapshot, this.context);

  // Start Overides
  @override
  DataRow getRow(int index) {
    var docSnapshot = asyncSnapshot.data.docs[index];
    Farmer farmer = Farmer.fromMapObject(docSnapshot.data());
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        // DataCell(Image.network(farmer.picture)),
        DataCell(Text(farmer.name)),
        DataCell(Text(farmer.name)),
        DataCell(Text(farmer.phone)),
        DataCell(Text(farmer.location)),
        DataCell(Text(farmer.gender)),
        DataCell(
          CustomSwitch(
            isSwitched: farmer.enabled,
            onChanged: (value) async {
              Map<String, dynamic> update = {'enabled': value};
              await DatabaseServices.updateDocument(
                'Farmers',
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
                      return ViewFarmer(
                        farmer: farmer,
                        farmerId: docSnapshot.id,
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
                      return UpdateFarmer(
                        farmer: farmer,
                        farmerDocSnap: docSnapshot,
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
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
                                ),
                              ),
                            ),
                            onPressed: () {
                              deleteFarmer(docSnapshot.id);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Delete',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
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
                                color: kPrimaryColor,
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
  int get rowCount => asyncSnapshot.data.size;

  @override
  int get selectedRowCount => 0;
}
