import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:http/http.dart' as http;

import '../../project_repository.dart';

Future<String> loginToApi() async {
  var loginHeaders = {
    'Content-Type': 'application/json',
  };

  var data = '{"username": "pefarrell@crh.com", "password": "Peterf4282"}';

  var res = await http.post('https://api.elis.rossum.ai/v1/auth/login',
      headers: loginHeaders, body: data);
  if (res.statusCode != 200)
    throw Exception('post error: statusCode= ${res.statusCode}');
  String key = res.body.substring(8, 48);
  return key;
}

Future<String> sendFile(file, filename) async {
  String key = await loginToApi();

  var url = Uri.parse("https://api.elis.rossum.ai/v1/queues/20383/upload");
  var request = new http.MultipartRequest("POST", url);
  Uint8List _bytesData =
      Base64Decoder().convert(file.toString().split(",").last);
  List<int> _selectedFile = _bytesData;
  request.headers.addAll({'Authorization': 'token $key'});

  request.files.add(http.MultipartFile.fromBytes('content', _selectedFile,
      //contentType: new MediaType('application', 'octet-stream'),
      filename: filename));

  request.send().then((response) {
    if (response.statusCode == 200)
      return ("Succesful Upload");
    else {
      return 'Upload Unsuccessful';
    }
  });
}

Future<List<DataPoint>> retrieveData(
    DateTime startTime, DateTime endTime, Project project) async {
  String key = await loginToApi();

  var res = await http.get(
      'https://api.elis.rossum.ai/v1/queues/20383/export?format=json&status=exported&columns=meta_file_name,invoice_id,date_issue,sender_name,amount_total&arrived_at_after=$startTime&arrived_at_before=$endTime',
      headers: {'Authorization': 'token $key'});
  if (res.statusCode != 200)
    throw Exception('get error: statusCode= ${res.statusCode}');
  var j = json.decode(res.body);
  //Set Exported To Number Of Times In The Loop
  int noInvoices = j['pagination']['total'];
    List<DataPoint> itemList = [];

  for (int k = 0; k < noInvoices; k ++){

  var invoiceInfo = j['results'][k]['content'][0];
  var amountsSection = j['results'][k]['content'][2];
  var vendorSection = j['results'][k]['content'][3];
  //['children'][0]['children'];

  var invoiceID = invoiceInfo['children'][0]['value'];
  var orderID = invoiceInfo['children'][1]['value'];
  var issueDate = invoiceInfo['children'][2]['value'];
  var currency = amountsSection['children'][1]['value'];
  var supplier = vendorSection['children'][0]['value'];
  var customer = vendorSection['children'][1]['value'];

  //iterateJson(json.encode(lineItemData));

  var items = j['results'][0]['content'][5]['children'][0]['children'] as List;

  for (var i = 0; i < items.length; i++) {
   
    String item_code;
    String description;
    String qty;
    String uom;
    String amount_base;
    String total_base;
    String amount_total;

    var details = items[i]['children'] as List;
    int j = 0;

    for (var x = 0; x < details.length; x++) {
      if (j == 7) {
        break;
      } else {
        var a = details[x]['schema_id'];
        var b =details[x]['value'];

        if(a.toString() == 'item_code') {
          item_code = b.toString();
        }
        else if(a.toString() == 'item_description') {
          description = b.toString();
        }
        else if(a.toString() == 'item_quantity'){
          qty = b.toString();
        }
        else if(a.toString() == 'item_uom'){
          uom = b.toString();
        }
               else if(a.toString() == 'item_amount_base'){
          amount_base = b.toString();
        }
               else if(a.toString() == 'item_total_base'){
          total_base = b.toString();
        }
               else if(a.toString() == 'item_amount_total'){
          amount_total = b.toString();
        }
        
        
        }
      }
    

    DataPoint test = DataPoint(
        invoice: invoiceID != null ? invoiceID :  "NA" ,
        supplier: supplier != null ? supplier : 'NA',
        customer: customer != null ? customer : "NA",
        order: orderID  != null ? orderID :  "NA",
        date: issueDate  != null ? issueDate :  "NA",
        code: item_code != null ? item_code : "NA" ,
        currency: currency != null ? currency :  "NA" ,
        description: description != null ? description :   "NA",
        qty: qty != null ? qty :   "NA",
        uom: uom != null ? uom :    "NA",
        price: amount_base != null ? amount_base :   "NA",
        base: total_base != null ? total_base :   "NA",
        total: amount_total != null ? amount_total :   "NA");
    itemList.add(test);
  }
    

  print(itemList[0]);
  }

    
  return itemList;
    
  //print(single);
}
