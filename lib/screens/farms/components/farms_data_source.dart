import 'package:farmasyst_admin_console/components/circular_image.dart';
import 'package:farmasyst_admin_console/components/custom_alert_dailog.dart';
import 'package:farmasyst_admin_console/models/farm.dart';
import 'package:farmasyst_admin_console/screens/farms/components/farms_module.dart';
import 'package:farmasyst_admin_console/screens/farms/update_farm.dart';
import 'package:farmasyst_admin_console/screens/farms/view_farm.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:flutter/material.dart';

class FarmsDataSource extends DataTableSource {
  List asyncSnapshot;
  BuildContext context;
  // Constructor
  FarmsDataSource(this.asyncSnapshot, this.context);

  // Start Overides
  @override
  DataRow getRow(int index) {
    var docSnapshot = asyncSnapshot[index];
    Farm farm = Farm.fromMapObject(docSnapshot.data());
    bool selected = false;
    return DataRow.byIndex(
      selected: selected,
      index: index,
      cells: <DataCell>[
        DataCell(Align(
          child: farm.pictures != null
              ? CircularImage(
                  child: Image.network(farm.pictures[0]),
                )
              : CircularImage(
                  child: null,
                ),
          alignment: Alignment.center,
        )),
        DataCell(Text(farm.farmId)),
        DataCell(Text(farm.farmerId.toUpperCase() ?? '')),
        DataCell(Text(farm.farmSize.toString())),
        DataCell(Text(farm.location)),
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
                      return ViewFarm(
                        farm: farm,
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
                      return UpdateFarm(
                        farm: farm,
                        farmDocSnap: docSnapshot,
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
                              deleteFarm(docSnapshot.id);
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
  int get rowCount => asyncSnapshot.length;

  @override
  int get selectedRowCount => 0;
}
