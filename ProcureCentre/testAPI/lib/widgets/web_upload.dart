import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:testAPI/apps/main_app.dart';

class FileUploadApp extends StatefulWidget {
  @override
  createState() => _FileUploadAppState();
}

class _FileUploadAppState extends State<FileUploadApp> {
  List<int> _selectedFile;
  Uint8List _bytesData;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool failure = false;


  startWebFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        //_handleResult(reader.result);
        sendFile(reader.result);
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile =  _bytesData;
    });
  }

  sendFile(file) async {
    print('start upload');
    //html.File uploadFile = file;
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
    print(key);


  var url = Uri.parse("https://api.elis.rossum.ai/v1/queues/20383/upload");
  var request = new http.MultipartRequest("POST", url);
  Uint8List _bytesData =
      Base64Decoder().convert(file.toString().split(",").last);
  List<int> _selectedFile = _bytesData;
    request.headers.addAll({'Authorization': 'token $key'});

  request.files.add(http.MultipartFile.fromBytes('content', _selectedFile,
      //contentType: new MediaType('application', 'octet-stream'),
      filename: "test"));

  request.send().then((response) {
    print("test");
    print(response.statusCode);
    if (response.statusCode == 200) print("Uploaded!");
  });
}

  void uploadFile() async {

      var queueID = '20383';
  var username = 'pefarrell@crh.com';
  var password = 'Peterf4282';
  var loginURL = 'https://api.elis.rossum.ai/v1/auth/login';
  var uploadURL = 'https://api.elis.rossum.ai/v1/queues/20383/upload';

    print('start upload');
    //html.File uploadFile = file;
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
    print(key);

     var url = Uri.parse(uploadURL);
    var request = new http.MultipartRequest("POST", url);
    print(url);
    request.files.add(http.MultipartFile.fromBytes('file', _selectedFile,
        //contentType: new MediaType('application', 'octet-stream'),
        filename: "file_up"));
    request.headers.addAll({'Authorization': 'token $key'});
    print('xxxxxxxx');
    var response = await request.send();
    print(response.statusCode);
    request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Uploaded!");
        print(response.statusCode);
        setState(() {
          failure  = false;
        });
      } else {
        setState(() {
          failure = true;
        });
      }
    
  }
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        child: new AlertDialog(
          title: new Text("Details"),
          //content: new Text("Hello World"),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(failure ? "failure" : "success" ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('OK'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => UploadApp()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('A Flutter Web file picker'),
        ),
        body: Container(
          child: new Form(
            autovalidate: true,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 28),
              child: new Container(
                  width: 350,
                  child: Column(children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MaterialButton(
                            color: Colors.pink,
                            elevation: 8,
                            highlightElevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            textColor: Colors.white,
                            child: Text('Select a file'),
                            onPressed: () {
                              startWebFilePicker();
                            },
                          ),
                          Divider(
                            color: Colors.teal,
                          ),
                          RaisedButton(
                            color: Colors.purple,
                            elevation: 8.0,
                            textColor: Colors.white,
                            onPressed: () {
                              uploadFile();
                            },
                            child: Text('Send file to server'),
                          ),
                        ])
                  ])),
            ),
          ),
        ),
      ),
    );
  }
}
