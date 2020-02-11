import 'dart:html';

import 'package:ProcureCentre/extraction/extraction_repository.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:firebase/firestore.dart' as fs;

import 'package:firebase/firebase.dart' as fb;

class FirebaseExtractionRepository implements ExtractionRepository{
  fs.Firestore store = fb.firestore();
    fb.UploadTask _uploadTask;


   @override
  Future<String> addFileToFirebase(Project project, String company, File file) async {
    //return store.collection("companies").doc(company).collection('projects').add(project.toEntity().toDocument());
    final filePath = '${file.name} ${DateTime.now()}';
   String url;
    // setState(() {
    //   print('work');
    fb.UploadTask _uploadTask = 
        fb.storage().ref('/Files/procurecentre.appspot.com/PDFs')
          .child(filePath)
          .put(file);

    var dowurl = await (await _uploadTask.future).ref.getDownloadURL();
    url = dowurl.toString();
      await store.collection('companies').doc(company).collection('projects').doc(project.id).set({'Files' : {'$filePath' : '$url'}},fs.SetOptions(merge: true));
      //update(data: {'Files':'downloadUrlTest', }, fieldsAndValues: );
    return url;
    
  }

  Future<String> getDownloadURL(Project project, String company, File file)async {
    String url;
    fb.StorageReference ref = fb.storage().ref('/Files/procurecentre.appspot.com/PDFs').child("${file.name}");
    var dowurl = await ref.getDownloadURL();
    url = dowurl.toString();
    return url;
  }

  
}