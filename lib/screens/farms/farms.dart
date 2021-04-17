import 'package:flutter/material.dart';
import 'package:flutter_web/constants.dart';
import 'components/jumbotron.dart';

class FarmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.fromLTRB(100, 10, 100, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                child: Text(
                  'Farms',
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
                padding: EdgeInsets.only(top: 10),
                width: size.width * 0.25,
                height: 40,
                child: TextFormField(
                  maxLines: 1,
                  minLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: IconButton(
                      padding: EdgeInsets.all(0),
                      iconSize: 26,
                      icon: Icon(
                        Icons.search,
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
              ), // TextField(
              //   decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       hintText: 'Enter a search term'),
              // ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: size.width,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Name',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Age',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Role',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Role',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Role',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Role',
                      ),
                    ),
                  ],
                  rows: List.generate(
                    10,
                    (index) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Sarah')),
                        DataCell(Text('19')),
                        DataCell(Text('Student')),
                        DataCell(Text('Student')),
                        DataCell(Text('Student')),
                        DataCell(Text('Student')),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
