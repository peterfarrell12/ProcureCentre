import 'dart:async';

import 'package:ProcureCentre/project_repository.dart';
import 'package:ProcureCentre/projects/models/project.dart';

abstract class ProjectRepository {
  Future<void> addNewProject(Project project, String company);

  Future<void> deleteProject(Project project, String company);

  Stream<List<Project>> projects(String company);

  // Stream<List<Project>> userProjectList(String company, String user);
  // Stream<List<Project>> companyProjectList(String company);

  Future<void> updateProject(Project project, String company);

  Stream listenToProjectsRealTime(String company);

  //

  Future<void> addNewProjectFile(Project project, String company, String file);

  Future<void> deleteProjectFile(Project project, String company, String file);

  Stream<List<Project>> projectFiles(String company, Project project);

  Future<void> updateProjectFiles(Project project, String company);

  Stream listenToProjectFilesRealTime(String company, Project project);
}
