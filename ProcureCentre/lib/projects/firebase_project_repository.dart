import 'dart:async';
import 'dart:html';
import 'package:ProcureCentre/projects/projects_repository.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart' as fb;
import 'entities/project_entity.dart';
import 'models/project.dart';

class FirebaseProjectRepository implements ProjectRepository {
  fs.Firestore store = fb.firestore();
  //fb.UploadTask _uploadTask;

  final StreamController<List<Project>> _projectsController =
      StreamController<List<Project>>.broadcast();

  @override
  Future<void> addNewProject(Project project, String company) async {
    return store
        .collection("companies")
        .doc(company)
        .collection('projects')
        .add(project.toEntity().toDocument());
  }

  @override
  Future<void> deleteProject(Project project, String company) async {
    return store
        .collection("companies")
        .doc(company)
        .collection('projects')
        .doc(project.id)
        .delete();
  }

  @override
  Stream<List<Project>> projects(String company) {
    return store
        .collection("companies")
        .doc(company)
        .collection('projects')
        .get()
        .asStream()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Project.fromEntity(ProjectEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateProject(Project update, String company) {
    return store
        .collection('companies')
        .doc(company)
        .collection("projects")
        .doc(update.id)
        .set(update.toEntity().toDocument());
  }

  @override
  Stream listenToProjectsRealTime(String company) {
    store
        .collection('companies')
        .doc(company)
        .collection('projects')
        .onSnapshot
        .listen((projectSnapshot) {
      if (projectSnapshot.docs.isNotEmpty) {
        var projects = projectSnapshot.docs
            .map((doc) => Project.fromEntity(ProjectEntity.fromSnapshot(doc)))
            .toList();

        _projectsController.add(projects);
      }
    });
    return _projectsController.stream;
  }

  @override
  Future<void> addNewProjectFile(
      Project project, String company, File uploadFile) async {
    store
        .collection('companies')
        .doc(company)
        .collection('projects')
        .doc(project.id)
        .update(data: {
      'test': 'downloadUrlTest',
    }, fieldsAndValues: [
      'Files'
    ]);

    return fb
        .storage()
        .ref('/Files/procurecentre.appspot.com/PDFs')
        .child("filePath")
        .put(uploadFile);
  }

  @override
  Future<void> deleteProjectFile(
      Project project, String company, File uploadFile) {}
  @override
  Stream<List<Project>> projectFiles(String company, Project project) {}
  @override
  Future<void> updateProjectFiles(Project project, String company, File file) {}
  @override
  Stream listenToProjectFilesRealTime(String company, Project project) {}
}

//   final output = await getTemporaryDirectory();
//   final file = File("${output.path}/example.pdf");
