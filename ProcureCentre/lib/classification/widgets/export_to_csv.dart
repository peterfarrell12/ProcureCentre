
import 'dart:convert';
import 'dart:html' as html;

import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/project_repository.dart';
import 'package:ProcureCentre/tender/models/tender.dart';
import 'package:csv/csv.dart';

getCsv(Project project, List<DataPoint> data) async {

 //create an element rows of type list of list. All the above data set are stored in associate list
//Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.


 List<List<dynamic>> rows = List<List<dynamic>>();
 rows.add(["Project  - ${project.name}"]);
 rows.add([]);
 rows.add(["Owner", project.user]);
 rows.add(["Scope", project.status]);
rows.add([]);
 rows.add(["",'Extracted Data', ]);
 rows.add([]);
 rows.add(["Category", "Invoice", "Order", "Supplier", "Date", "Code", "Description", "UOM", "QTY", "Price", "Total"]);
  for (int i = 0; i <data.length;i++) {

//row refer to each column of a row in csv file and rows refer to each row in a file
    List<dynamic> row = List();
        row.add(data[i].category);

    row.add(data[i].invoice);
    row.add(data[i].order);
    row.add(data[i].supplier);
    row.add(data[i].date);
    row.add(data[i].code);
    row.add(data[i].description);
    row.add(data[i].uom);
    row.add(data[i].qty);
    row.add(data[i].price);
    row.add(data[i].total);
    row.add("");
    row.add("");
    rows.add(row);
  }



//store file in documents folder

    // String dir = (await getExternalStorageDirectory()).absolute.path + "/documents";
    //  var file = "$dir";
    // print(LOGTAG+" FILE " + file);

// convert rows to String and write as csv file

    String csv = const ListToCsvConverter().convert(rows);

   // f.writeAsString(csv);


// prepare
final bytes = utf8.encode(csv);
final blob = html.Blob([bytes]);
final url = html.Url.createObjectUrlFromBlob(blob);
final anchor = html.document.createElement('a') as html.AnchorElement
  ..href = url
  ..style.display = 'none'
  ..download = '${project.name}.csv';
html.document.body.children.add(anchor);

// download
anchor.click();

// cleanup
html.document.body.children.remove(anchor);
html.Url.revokeObjectUrl(url);

    print(csv);
  


}