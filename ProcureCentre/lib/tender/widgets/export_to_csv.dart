
import 'dart:convert';
import 'dart:html' as html;

import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/tender/models/tender.dart';
import 'package:csv/csv.dart';

getCsv(Tender tender, List<DataPoint> data) async {




 List<List<dynamic>> rows = List<List<dynamic>>();
 rows.add(["Tender Document - ${tender.company}"]);
 rows.add([]);
 rows.add(["Title", tender.title]);
 rows.add(["Owner", tender.user]);
 rows.add(["Length", "${tender.length} Days"]);
 rows.add(["Scope", tender.scope]);
rows.add([]);
 rows.add(["",'Pricing', ]);
 rows.add([]);
 rows.add(["Item Code", "Item Description", "UOM", "Quantity", "Price", "Total"]);
  for (int i = 0; i <data.length;i++) {

//row refer to each column of a row in csv file and rows refer to each row in a file
    List<dynamic> row = List();
    row.add(data[i].code);
    row.add(data[i].description);
    row.add(data[i].uom);

    row.add(data[i].qty);

    row.add("");

    row.add("");

    rows.add(row);
  }



    String csv = const ListToCsvConverter().convert(rows);


final text = '${tender.title}';

// prepare
final bytes = utf8.encode(csv);
final blob = html.Blob([bytes]);
final url = html.Url.createObjectUrlFromBlob(blob);
final anchor = html.document.createElement('a') as html.AnchorElement
  ..href = url
  ..style.display = 'none'
  ..download = '${tender.title}.csv';
html.document.body.children.add(anchor);

// download
anchor.click();

// cleanup
html.document.body.children.remove(anchor);
html.Url.revokeObjectUrl(url);

    print(csv);
  


}