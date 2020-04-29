import 'dart:html';

import 'package:ProcureCentre/extraction/entities/data_entity.dart';
import 'package:ProcureCentre/extraction/extraction_repository.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:firebase/firestore.dart' as fs;

import 'package:firebase/firebase.dart' as fb;

import 'models/extracted_data.dart';

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

  Future<void> addData(Project project, String company, List<DataPoint> data) async {
    print("Hello");
    for(var i = 0; i < data.length; i++)  {
      await store.collection("companies")
        .doc(company)
        .collection('projects')
        .doc(project.id)
        .collection('data')
        .add(data[i].toEntity().toDocument());
    }

    

    return '${data.length} number of items uploaded';        
  }

  @override
  Future<List<DataPoint>> getData(Project project, String company, ) async {
    var qShot = await store
        .collection("companies")
        .doc(company)
        .collection('projects')
        .doc(project.id)
        .collection('data')
        .get();

        return qShot.docs.map((e) => DataPoint.fromEntity(DataEntity.fromSnapshot(e))).toList();
   
  }

   @override
  Future<void> updateDataPoint(DataPoint dp, Project project, String company) {
    print(dp.id);
    return store
        .collection('companies')
        .doc(company)
        .collection("projects")
        .doc(project.id)
        .collection('data')
        .doc(dp.id)
        .set(dp.toEntity().toDocument());
  }

    @override
  Future<void> deleteProject(Project project, String company, List<String> id) async {
     for(int i = 0; i < id.length; i ++){
       store
        .collection("companies")
        .doc(company)
        .collection('projects')
        .doc(project.id)
        .collection("data")
        .doc(id[i])
        .delete();
    }
    
  }
}