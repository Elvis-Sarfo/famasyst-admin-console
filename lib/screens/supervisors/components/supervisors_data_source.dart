import 'package:farmasyst_admin_console/components/circular_image.dart';
import 'package:farmasyst_admin_console/components/custom_alert_dailog.dart';
import 'package:farmasyst_admin_console/components/custom_switch.dart';
import 'package:farmasyst_admin_console/models/supervisor.dart';
import 'package:farmasyst_admin_console/screens/supervisors/components/supervisor_module.dart';
import 'package:farmasyst_admin_console/screens/supervisors/update_supervisor.dart';
import 'package:farmasyst_admin_console/screens/supervisors/view_supervisors.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';
import 'package:flutter/material.dart';

class SupervisorDataSource extends DataTableSource {
  List asyncSnapshot;
  BuildContext context;
  // Constructor
  SupervisorDataSource(this.asyncSnapshot, this.context);

  // Start Overides
  @override
  DataRow getRow(int index) {
    var docSnapshot = asyncSnapshot[index];
    Supervisor supervisor = Supervisor.fromMapObject(docSnapshot.data());
    bool selected = false;
    return DataRow.byIndex(
      selected: selected,
      // onSelectChanged: (value) {
      //   selected = value;
      //   // showDialog(
      //   //   context: context,
      //   //   builder: (BuildContext context) {
      //   //     return ViewSupervisor(
      //   //       supervisor: supervisor,
      //   //       supervisorId: docSnapshot.id,
      //   //     );
      //   //   },
      //   // );
      // },
      index: index,
      cells: <DataCell>[
        // DataCell(Image.network(supervisor.picture)),
        DataCell(Align(
          child: supervisor.picture != null
              ? CircularImage(
                  child: Image.network(supervisor.picture),
                )
              : CircularImage(
                  child: null,
                ),
          alignment: Alignment.center,
        )),
        DataCell(Text(supervisor.name)),
        DataCell(Text(supervisor.phone)),
        DataCell(Text(supervisor.location)),
        DataCell(Text(supervisor.gender.toUpperCase())),
        DataCell(
          CustomSwitch(
            isSwitched: supervisor.enabled,
            onChanged: (value) async {
              Map<String, dynamic> update = {'enabled': value};
              await DatabaseServices.updateDocument(
                'Supervisors',
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
                      return ViewSupervisor(
                        supervisor: supervisor,
                        supervisorId: docSnapshot.id,
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
                      return UpdateSupervisor(
                        supervisor: supervisor,
                        supervisorDocSnap: docSnapshot,
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
                              deleteSupervisor(docSnapshot.id);
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
