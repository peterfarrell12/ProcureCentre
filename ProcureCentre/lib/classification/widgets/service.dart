import 'dart:html' as html;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> predictClass(List<String> text) async {

  Autogenerated testData = Autogenerated(message: text);
  var maybe = jsonEncode(testData);
  print(maybe);
  var loginHeaders = {
    'Content-Type': 'application/json',
  };
  //var data = json.encode("{ 'message' : ['levovo', 'grinding aid']}");
  print('meh');
  var res = await http.post('http://127.0.0.1:5000/',
      body: maybe, 
      headers: loginHeaders
);
print(res);
  print(res.statusCode);
  if (res.statusCode != 200)
    throw Exception('post error: statusCode= ${res.statusCode}');
  else {
    print(res.statusCode);
    var dRes = json.decode(res.body);
    print(dRes);
  }
}

class Autogenerated {
  List<String> message;

  Autogenerated({this.message});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    message = json['message'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}