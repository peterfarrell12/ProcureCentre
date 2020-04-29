import 'dart:async';
import 'dart:html';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart' as fb;
import 'home_repository.dart';

class FirebaseHomeRepository implements HomeRepository {
  fs.Firestore store = fb.firestore();
  //fb.UploadTask _uploadTask;

  @override
  Future<Map> getCompanyData(String company) async {
    var companyUsers = await store
        .collection('companies')
        .doc(company)
        .collection('users')
        .get()
        .then((value) => value.docs.length);
    int companyProjects = await store
        .collection('companies')
        .doc(company)
        .collection('projects')
        .get()
        .then((value) => value.docs.length);
    int activeProjects = await store
        .collection('companies')
        .doc(company)
        .collection('projects')
        .get()
        .then((value) => value.docs
            .where((element) => element.data()["Status"] != "Completed")
            .length);
    int tendersCreated = await store.collectionGroup("tenders").get().then(
        (value) => value.docs
            .where((element) => element.data()['Company'] == company)
            .length);
    List<String> _invoices = [];
    int dataLines = 0;
    var projectID = [];
    await store
        .collection('companies')
        .doc(company)
        .collection('projects')
        .get()
        .then((value) => value.docs.forEach((element) {
              projectID.add(element.id);
            }));
    for (int i = 0; i < projectID.length; i++) {
      await store
          .collection('companies')
          .doc(company)
          .collection('projects')
          .doc(projectID[i])
          .collection('data')
          .get()
          .then((value) => value.docs.forEach((element) {
                _invoices.add(element.data()['Invoice ID']);
                dataLines = dataLines + 1;
              }));
    }
    List<String> _uniqueInvoices = _invoices.toSet().toList();

    int completed = await store
        .collection('companies')
        .doc(company)
        .collection('projects')
        .get()
        .then((value) => value.docs
            .where((element) =>
                element.data()["Dashboard"]['Completed'] == true &&
                element.data()["Tender Creation"]['Completed'] == true &&
                element.data()['Classification']['Completed'] == true &&
                element.data()['Extraction']['Completed'] == true)
            .length);

    double completedProjectsPercentage = (completed / companyProjects) * 100;
    String projectsPercentage = "${completedProjectsPercentage.round()}%";
    List<Map> userDetails = [];
    List<Table1> table1Data = [];
    var users = await store
        .collection('companies')
        .doc(company)
        .collection('users')
        .get()
        .then((value) => value.docs.forEach((element) {
              userDetails.add({"Name": element.data()['Username']});
            }));
    for (int i = 0; i < userDetails.length; i++) {
      String user;
      int projects;
      int active;
      int tenders;

      await store
          .collectionGroup('projects')
          .where("User", "==", userDetails[i]['Name'])
          .get()
          .then((value) {
        projects = value.docs.length;
        active = value.docs
            .where((element) => element.data()['Status'] != 'Completed')
            .length;
      });
      await store
          .collectionGroup('tenders')
          .where("User", "==", userDetails[i]['Name'])
          .get()
          .then((value) {
        tenders = value.docs.length;
      });
      user = userDetails[i]['Name'];
      table1Data.add(Table1(
          user: user, projects: projects, active: active, tenders: tenders));
    }
    for (int i = 0; i < table1Data.length; i++) {
    }
    // List<Map> projectDetails = [
    //   {"Feature": "Extraction"},
    //   {"Feature": "Classification"},
    //   {"Feature": "Dashboard"},
    //   {"Feature": "Tender"}
    // ];

    List<Table2> table2Data = [];
    await store
        .collection('companies')
        .doc(company)
        .collection('projects')
        .get()
        .then((value) {
      var extract = value.docs
          .where((element) => element.data()['Extraction']['Completed'] == true)
          .length;
      var feature1 = 'Extraction';
      var project1 = extract;
      var percentage1 = (extract / companyProjects) * 100;
      table2Data.add(Table2(
          feature: feature1, projects: project1, percentage: percentage1));
      var classify = value.docs
          .where((element) =>
              element.data()['Classification']['Completed'] == true)
          .length;
      var feature2 = 'Classification';
      var project2 = classify;
      var percentage2 = (classify / companyProjects) * 100;
      table2Data.add(Table2(
          feature: feature2, projects: project2, percentage: percentage2));
      var dashboard = value.docs
          .where((element) => element.data()['Dashboard']['Completed'] == true)
          .length;
      var feature3 = 'Dashboard';
      var project3 = dashboard;
      var percentage3 = (dashboard / companyProjects) * 100;
          table2Data.add(Table2(
          feature: feature3, projects: project3, percentage: percentage3));
      var tender = value.docs
          .where((element) =>
              element.data()['Tender Creation']['Completed'] == true)
          .length;
          var feature4 = "Tender";
      var project4 = tender;
      var percentage4 = (tender / companyProjects) * 100;
          table2Data.add(Table2(
          feature: feature4, projects: project4, percentage: percentage4));
    });

    // print(projectDetails);
    // print(completedProjectsPercentage);

    return {
      "Users": companyUsers,
      "Projects": companyProjects,
      "Active": activeProjects,
      "Tenders": tendersCreated,
      "Invoices": _uniqueInvoices.length,
      "Data": dataLines,
      "Completed": completedProjectsPercentage,
      "Table 1": table1Data,
       "Table 2" : table2Data,
    };
  }

  // @override
  // Future<void> addNewProjectFile(
  //     Project project, String company, File uploadFile) async {
  //   store
  //       .collection('companies')
  //       .doc(company)
  //       .collection('projects')
  //       .doc(project.id)
  //       .update(data: {
  //     'test': 'downloadUrlTest',
  //   }, fieldsAndValues: [
  //     'Files'
  //   ]);

  //   return fb
  //       .storage()
  //       .ref('/Files/procurecentre.appspot.com/PDFs')
  //       .child("filePath")
  //       .put(uploadFile);
  // }

  // @override
//   Future<void> deleteProjectFile(
//       Project project, String company, File uploadFile) {}
//   @override
//   Stream<List<Project>> projectFiles(String company, Project project) {}
//   @override
//   Future<void> updateProjectFiles(Project project, String company, File file) {}
//   @override
//   Stream listenToProjectFilesRealTime(String company, Project project) {}
// }

//   final output = await getTemporaryDirectory();
//   final file = File("${output.path}/example.pdf");

}

class Table1 {
  String user;
  int projects;
  int active;
  int tenders;

  Table1({this.user, this.projects, this.active, this.tenders});
}

class Table2 {
  String feature;
  int projects;
  double percentage;

  Table2({this.feature, this.projects, this.percentage});
}
