import 'dart:async';



import 'package:ProcureCentre/projects/projects_repository.dart';
import 'package:firebase/firestore.dart' as fs;

import 'package:firebase/firebase.dart' as fb;

import 'entities/project_entity.dart';
import 'models/project.dart';


class FirebaseProjectRepository implements ProjectRepository {

    fs.Firestore store = fb.firestore();

    final StreamController<List<Project>> _projectsController = StreamController<List<Project>>.broadcast();


  @override
  Future<void> addNewProject(Project project, String company) async {
    return store.collection("companies").doc(company).collection('projects').add(project.toEntity().toDocument());
  }

  @override
  Future<void> deleteProject(Project project, String company) async {
    return store.collection("companies").doc(company).collection('projects').doc(project.id).delete();
  }

    @override
  Stream<List<Project>> projects(String company) {
    return store.collection("companies").doc(company).collection('projects').get().asStream().map((snapshot) {
      return snapshot.docs
          .map((doc) => Project.fromEntity(ProjectEntity.fromSnapshot(doc)))
          .toList();
    });
  }

 @override
  Future<void> updateProject(Project update, String company) {
    return store.collection('companies').doc(company).collection("projects")
        .doc(update.id).set(update.toEntity().toDocument());
  }

  @override
  Stream listenToProjectsRealTime(String company){
    store.collection('companies').doc(company).collection('projects').onSnapshot.listen((projectSnapshot){
      if (projectSnapshot.docs.isNotEmpty){
        var projects = projectSnapshot.docs
        .map((doc) => Project.fromEntity(ProjectEntity.fromSnapshot(doc)))
          .toList();

          _projectsController.add(projects);
      }

    });
          return _projectsController.stream;

  }

}

