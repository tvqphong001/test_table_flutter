import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_table/json_table.dart';
import 'package:json_table/json_table_column.dart';

class CustomColumnTable extends StatefulWidget {
  @override
  _CustomColumnTableState createState() => _CustomColumnTableState();
}

class dataJSon {
  String region;
  String daily;
  String monthly;
  String pership;

  dataJSon({this.region, this.daily, this.monthly, this.pership});

  factory dataJSon.fromJson(Map<String, dynamic> json) {
    return dataJSon(
        region: json["REGION"],
        daily: json["DAILY_REV"],
        monthly: json["MONTHLY_REV"],
        pership: json["REV_PER_SHPT"]);
  }
}

class _CustomColumnTableState extends State<CustomColumnTable> {
  List<dataJSon> list;
  var rest;
  final String jsonSample =
      '[{"REGION":"South","Daily":"200000","Monthly":3000000,"Last Month":"320000","Varience":"30%","PerShipment":"3"},{"REGION":"Easth","Daily":"300000",'
      '"Monthly":2003000,"Last Month":"300000","Varience":"10%","PerShipment":"4"},{"REGION":"DAD","Daily":"30000","Monthly":100000,"Last Month":"400000","Varience":"20%",'
      '"PerShipment":"3"},{"REGION":"HNI","Daily":"300000","Monthly":230000,"Last Month":"30000","Varience":"15%","PerShipment":"3"},'
      '{"REGION":"HCM","Daily":"3000000","Monthly":3000000,"Last Month":"3999000","Varience":"11%","PerShipment":"1"},{"REGION":"North","Daily":"30000",'
      '"Monthly":20000,"Last Month":"300000","Varience":"16%","PerShipment":"3"}]';
  var jsonToTable;

  bool toggle = true;
  List<JsonTableColumn> columns;

  Future<List<dataJSon>> getData(jsonToTable) async {
    var link =
        'http://uat.ebooking.kerryexpress.com.vn/api/Revenue/GetRevenueDataByDate/2019-12-16';
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      rest = data["Data"] as List;
      jsonToTable = rest.toString();
//      print(rest);

      list = rest.map<dataJSon>((json) => dataJSon.fromJson(json)).toList();
//      jsonToTable = list;
    }
//    print("List: " + list.toString());
    print("List Size: ${list.length}");
    return list;
  }

  @override
  void initState() {
    super.initState();

    getData(jsonToTable);
    columns = [
      JsonTableColumn("REGION", label: "regi"),
      JsonTableColumn("DAILY_REV", label: "Daily"),
      JsonTableColumn("MONTHLY_REV", label: "Monthly"),
      JsonTableColumn("REV_PER_SHPT", label: "Rev"),
    ];
  }

  void getJson(String jsonPart) async {
    var url =
        'http://uat.ebooking.kerryexpress.com.vn/api/Revenue/GetRevenueDataByDate/2019-12-16';
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var data = json.decode(response.body);
    var rest = data["DATA"] as List;
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var res = data["DATA"] as List;
    }
    jsonPart = (response.body).toString();
    print(jsonPart);
  }

  @override
  Widget build(BuildContext context) {
//    var json = jsonDecode(list);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  JsonTable(
                    list,
//                    columns: columns,
//                    tableHeaderBuilder: (String header) {
//                      return Container(
//                        padding: EdgeInsets.symmetric(
//                            horizontal: 5.0, vertical: 10.0),
//                        decoration: BoxDecoration(
//                            border: Border(
//                          bottom: BorderSide(width: 1.1, color: Colors.black),
//                        )), // color background of header
//                        child: Text(
//                          header,
//                          textAlign: TextAlign.center,
//                          style: Theme.of(context).textTheme.display1.copyWith(
//                                fontWeight: FontWeight.bold,
//                                fontSize: 15.0,
//                              ), // font color of header
//                        ),
//                      );
//                    },
//                    tableCellBuilder: (value) {
//                      return Container(
//                        padding: EdgeInsets.symmetric(
//                            horizontal: 20.0, vertical: 20.0),
//                        decoration: BoxDecoration(
//                            border: Border(
//                          top: BorderSide(width: 0.1, color: Colors.black),
//                          bottom: BorderSide(width: 0.1, color: Colors.black),
//                        )),
//                        child: Text(
//                          value,
//                          textAlign: TextAlign.center,
//                          style: Theme.of(context)
//                              .textTheme
//                              .display1
//                              .copyWith(fontSize: 13.0, color: Colors.black),
//                        ),
//                      );
//                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
