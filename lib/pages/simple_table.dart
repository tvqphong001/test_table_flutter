import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

class SimpleTable extends StatefulWidget {
  @override
  _SimpleTableState createState() => _SimpleTableState();
}

class _SimpleTableState extends State<SimpleTable> {
  final String jsonSample =
      '[{"Region":"South","Daily":"200000","Monthly":3000000,"Last Month":"320000","Varience":"30%","PerShipment":"3"},{"Region":"Easth","Daily":"300000",'
      '"Monthly":2003000,"Last Month":"300000","Varience":"10%","PerShipment":"4"},{"Region":"DAD","Daily":"30000","Monthly":100000,"Last Month":"400000","Varience":"20%",'
      '"PerShipment":"3"},{"Region":"HNI","Daily":"300000","Monthly":230000,"Last Month":"30000","Varience":"15%","PerShipment":"3"},'
      '{"Region":"HCM","Daily":"3000000","Monthly":3000000,"Last Month":"3999000","Varience":"11%","PerShipment":"1"},{"Region":"North","Daily":"30000",'
      '"Monthly":20000,"Last Month":"300000","Varience":"16%","PerShipment":"3"}]';
  bool toggle = true;

  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(jsonSample);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: toggle
            ? Column(
                children: [
                  JsonTable(
                    json,
//                    showColumnToggle: false,
                    tableHeaderBuilder: (String header) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                        ), // color background of header
                        child: Text(
                          header,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ), // font color of header
                        ),
                      );
                    },
                    tableCellBuilder: (value) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 2.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5,
                                color: Colors.blueGrey.withOpacity(0.5))),
                        child: Text(
                          value,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(fontSize: 15.0, color: Colors.grey),
                        ),
                      );
                    },
                    allowRowHighlight: true,
                    rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
                    paginationRowCount: 500,
                  ),
//                  SizedBox(
//                    height: 40.0,
//                  ),
//                  Text("Simple table which creates table direclty from json")
                ],
              )
            : Center(),
      ),
//      floatingActionButton: FloatingActionButton(
//          child: Icon(Icons.grid_on),
//          onPressed: () {
//            setState(
//              () {
//                toggle = !toggle;
//              },
//            );
//          }),
    );
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }
}
