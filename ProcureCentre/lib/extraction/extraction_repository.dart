import 'dart:html';

import 'package:ProcureCentre/projects/models/project.dart';

abstract class ExtractionRepository {

  //Future<void> isExtractionComplete(Project project, String company);

  //Future<void> getExtractionData(Project project, String company);

  Future<String> addFileToFirebase(Project project,String company, File file);

  Future<String> getDownloadURL(Project project,String company, File file);

}