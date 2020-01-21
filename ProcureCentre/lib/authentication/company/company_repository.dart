import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart';

class CompanyRepository {


   fs.Firestore store = firestore();

   void createCompany(String companyName, String companyPIN, String companyABB)async {
  fs.DocumentReference ref =  store.collection('companies').doc(companyName);
  
  ref.set({

    'Company Name' : companyName,
    'Company PIN' : companyPIN,
    'Company ABB' : companyABB
  });
}


  Future<bool> checkingPIN(String name, String pin) async {
  final fs.DocumentSnapshot result = await store
    .collection('companies')
    .doc(name)
    .get();
  final fs.DocumentSnapshot documents = result;
  
  return documents.data()['Company PIN'].toString() == pin.toString();
}
Future<List<String>> companyList() async {

   List<String> companies = [];

   await store
    .collection('Companies')
    .get()
    .then((fs.QuerySnapshot snapshot) {
      snapshot.forEach((callback){
        companies.add(callback.id);
      });
    });

    return companies;
 }

    Future<String> getCompanyName (String userEmail) async {
    String comp;
    List<String> companies = await companyList();



        for (var i = 0; i < companies.length; i++) {
          store.collection('companies').doc(companies[i]).collection('users').get().
          then((val) {
            val.forEach((user){
              if(user.data()['Email'] == userEmail) {
                comp = user.data()['Company'];
              }
            });
          });
        }


    return comp;
  }
}