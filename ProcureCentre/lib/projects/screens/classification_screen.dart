import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:http';

class ClassificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.of(context).pop();
        },),
        title: Text("Classification Screen"),
      ),
      body: 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Upload File Here"),
            RaisedButton(
              child: Text('Upload'),
              onPressed: (){
                _startFilePicker();
              },
            )
          ],
        ),
      ),
    );
  }
  _startFilePicker() async {
InputElement uploadInput = FileUploadInputElement();
uploadInput.click();

uploadInput.onChange.listen((e) {
  // read file content as dataURL
  final files = uploadInput.files;
  if (files.length == 1) {
    final file = files[0];
    final reader = new FileReader();

    reader.onLoadEnd.listen((e) {
      //_handleResult(reader.result);
    });
    reader.readAsDataUrl(file);
  }
});
}

_sendToApi() async {
  var uri = Uri.parse("http://pub.dartlang.org/packages/create");
var request = new http.MultipartRequest("POST", url);
request.fields['user'] = 'john@doe.com';
request.files.add(new http.MultipartFile.fromFile(
    'package',
    new File('build/package.tar.gz'),
    contentType: new ContentType('application', 'x-tar'));
request.send().then((response) {
  if (response.statusCode == 200) print("Uploaded!");
});
}
}
