import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> sendFile(file, filename) async {
  print('start upload');
  //html.File uploadFile = file;
  var loginHeaders = {
    'Content-Type': 'application/json',
  };

  print('logging in');

  var data = '{"username": "XXXXX", "password": "XXXXX"}';

  var res = await http.post('https://api.elis.rossum.ai/v1/auth/login',
      headers: loginHeaders, body: data);
  if (res.statusCode != 200)
    throw Exception('post error: statusCode= ${res.statusCode}');
  String key = res.body.substring(8, 48);
  print(key);

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
    print("test");
    print(response.statusCode);
    if (response.statusCode == 200)
      return "Succesful Upload";
    else {
      return 'Upload Unsuccessful';
    }
  });
}

void checkExtraction(){

}
