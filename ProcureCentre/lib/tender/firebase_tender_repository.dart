import 'dart:html';

import 'package:ProcureCentre/extraction/entities/data_entity.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/tender/tender_repository.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:ProcureCentre/tender/models/tender.dart';
import 'package:firebase/firestore.dart' as fs;

import 'package:firebase/firebase.dart' as fb;

import 'entities/tender_entity.dart';



class FirebaseTenderRepository implements TenderRepository{
  fs.Firestore store = fb.firestore();



@override
  Future<void> addTender(Project project, String company, Tender tender) async {
    
      await store.collection("companies")
        .doc(company)
        .collection('projects')
        .doc(project.id)
        .collection('tenders')
        .add(tender.toEntity().toDocument());

        return('??');
    }
  
 @override
 Future<List<DataPoint>> getDataPoints(Project project, String company, List<String> ids) async{

   List<DataPoint> data = [];

   for (int i = 0; i < ids.length; i++) {
     var qShot = await store
        .collection("companies")
        .doc(company)
        .collection('projects')
        .doc(project.id)
        .collection('data')
        .doc(ids[i]).get();

        DataPoint dp =   DataPoint.fromEntity(DataEntity.fromSnapshot(qShot));

        data.add(dp);
   }

   return data;


 }

  @override
  Future<List<Tender>> getTenders(Project project, String company)async {
    List<Tender>  list = [];
     await store
        .collection("companies")
        .doc(company)
        .collection('projects')
        .doc(project.id)
        .collection('tenders')
        .get()
        .then((value) {
          value.docs.forEach((element) {print(element.data()['Categories']);});
           list = value.docs.map((doc) => Tender.fromEntity(TenderEntity.fromSnapshot(doc))).toList(); 
        });
    return list;
  }


   @override
  Future<void> updateTender(Tender tender, Project project, String company) {
    print(tender.id);
    return store
        .collection('companies')
        .doc(company)
        .collection("projects")
        .doc(project.id)
        .collection('tender')
        .doc(tender.id)
        .set(tender.toEntity().toDocument());
  }

@override
Future<int> getLength(Project project, String company) async{
  var len = await store
        .collection('companies')
        .doc(company)
        .collection("projects")
        .doc(project.id)
        .collection('tenders')
        .get().then((value) => value.docs.length);

    return len;
}
}