import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbols.dart';

import '../../project_repository.dart';

Future<String> loginToApi() async {
  var loginHeaders = {
    'Content-Type': 'application/json',
  };

  print('logging in');

  var data = '{"username": "pefarrell@crh.com", "password": "Peterf4282"}';

  var res = await http.post('https://api.elis.rossum.ai/v1/auth/login',
      headers: loginHeaders, body: data);
  if (res.statusCode != 200)
    throw Exception('post error: statusCode= ${res.statusCode}');
  String key = res.body.substring(8, 48);
  return key;
}

Future<bool> sendFile(List<String> file, List<String> filenames) async {
  String key = await loginToApi();

for(int i =0; i < file.length; i++){

  // var url = Uri.parse("https://api.elis.rossum.ai/v1/queues/20383/upload");
    var url = Uri.parse("https://api.elis.rossum.ai/v1/queues/20383/upload");

  var request = new http.MultipartRequest("POST", url);

  
    Uint8List _bytesData =
      Base64Decoder().convert(file[i].toString().split(",").last);
  List<int> _selectedFile = _bytesData;
  request.headers.addAll({'Authorization': 'token $key'});
  print(filenames);
  print('....');

  request.files.add(http.MultipartFile.fromBytes('content', _selectedFile,
      //contentType: new MediaType('application', 'octet-stream'),
      filename: filenames[i].toString()));
  print('....//');

  return request.send().then((response) {
    // print(response.statusCode);
    if (response.statusCode == 201){
      return  true;
    }
    else {
      return false;
    }
  });
}

  }
  

Future<List<DataPoint>> retrieveData(
    DateTime startTime, DateTime endTime, Project project) async {
  String key = await loginToApi();
print('successfully logged in $key');
print(startTime);
  var res = await http.get(
      'https://api.elis.rossum.ai/v1/queues/20383/export?format=json&status=exported&columns=meta_file_name,invoice_id,date_issue,sender_name,amount_total',
      headers: {'Authorization': 'token $key'});

  print(".....");
  print(res.statusCode);
  if (res.statusCode != 200)
    throw Exception('get error: statusCode= ${res.statusCode}');
  var j = json.decode(res.body);
  //Set Exported To Number Of Times In The Loop
  int noInvoices = j['pagination']['total'];
    List<DataPoint> itemList = [];
  print(noInvoices);
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

  var items = j['results'][k]['content'][5]['children'][0]['children'] as List;
  for (var i = 0; i < items.length; i++) {
   
    String item_code;
    String description;
    String quantity;
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
          description = b.toString();        }
        else if(a.toString() == 'item_quantity'){
          quantity = b.toString();
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
      amount_total = amount_total.isEmpty ? "1.0" : amount_total;
      print(amount_total);
            quantity = quantity.isEmpty ? "1.0" : quantity;

      print(quantity);

    DataPoint test = DataPoint(
        invoice: invoiceID != null ? invoiceID :  "NA" ,
        supplier: supplier != null ? supplier : 'NA',
        customer: customer != null ? customer : "NA",
        order: orderID  != null ? orderID :  "NA",
        date: issueDate  != null ? issueDate :  "NA",
        code: item_code != null ? item_code : "NA" ,
        currency: currency != null ? currency :  "NA" ,
        description: description != null ? description :   "NA",
        qty: quantity.isNotEmpty ? quantity :  "1.0",
        uom: uom.isNotEmpty ? uom :  "Each",
        price: amount_base.isNotEmpty ? amount_base : (double.parse(amount_total) / double.parse(quantity)).toString() ,
        base: total_base != null ? total_base :   "NA",
        
        total: amount_total.isNotEmpty ? amount_total :     "NA"       ,
);
    itemList.add(test);
  }
    

  }
    
  return itemList;
    
}
