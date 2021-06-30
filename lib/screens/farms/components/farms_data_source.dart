import 'package:farmasyst_admin_console/components/circular_image.dart';
import 'package:farmasyst_admin_console/components/custom_alert_dailog.dart';
import 'package:farmasyst_admin_console/components/popup_button.dart';
import 'package:farmasyst_admin_console/models/farm.dart';
import 'package:farmasyst_admin_console/models/supervisor.dart';
import 'package:farmasyst_admin_console/notifiers/supervisors_state%20.dart';
import 'package:farmasyst_admin_console/screens/farms/components/farms_module.dart';
import 'package:farmasyst_admin_console/screens/farms/update_farm.dart';
import 'package:farmasyst_admin_console/screens/farms/view_farm.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        DataCell(Text(farm.farmId.toString())),
        DataCell(Text(
            '${farm.farmer != null ? farm.farmer['name'] + ' @ ' + farm.farmer['phone'] : ''} ')),
        DataCell(Text(farm.farmSize.toString())),
        DataCell(Text(farm.location)),
        DataCell(Row(
          children: [
            Consumer<SupervisorsState>(builder: (context, state, child) {
              // var supervisorSnapshot;
              return PopupButton(
                icon: Icon(
                  Icons.edit,
                  color: kPrimaryColor,
                ),
                items: state.getSupervisors.map((supervisor) {
                  Supervisor _supervisor =
                      Supervisor.fromMapObject(supervisor.data());
                  return {
                    'value': {'id': supervisor.id, 'data': supervisor},
                    'child': Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.5, color: kPrimaryLight),
                        ),
                      ),
                      child: Row(
                        children: [
                          _supervisor.picture != null
                              ? CircularImage(
                                  child: Image.network(_supervisor.picture),
                                )
                              : CircularImage(
                                  child: null,
                                ),
                          Text('${_supervisor.name}')
                        ],
                      ),
                    )
                  };
                }).toList(),
                onSelected: (value) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        title:
                            'Are you sure you want to assign ${farm.farmId ?? ''} to ${value['data']['name'] ?? ''} from  ${value['data']['location'] ?? ''}',
                        descriptions: 'This action cannot be undone!',
                        dialogIcon: Icon(
                          Icons.assignment_ind,
                          color: kSecondaryColor,
                          size: 70,
                        ),
                        actionsButtons: [
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
                              assignFarmToSupervisor(docSnapshot.id, {
                                'id': value['id'],
                                'name': value['data']['name'],
                                'location': value['data']['location'],
                                'phone': value['data']['phone'],
                                'email': value['data']['email'],
                                'specializations': value['specializations'],
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Yes, Assign',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  kSecondaryColor),
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
              );
            }),
            // todo: display the id of the supervisor
            Expanded(
              child: Text(
                farm.supervisor != null
                    ? farm.supervisor['name'] ?? ''
                    : 'Not Assigned',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )),
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
                              deleteFarm(docSnapshot.id);
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
