import 'dart:html';

import 'package:ProcureCentre/projects/models/project.dart';

import 'models/extracted_data.dart';

abstract class ExtractionRepository {

  //Future<void> isExtractionComplete(Project project, String company);

  //Future<void> getExtractionData(Project project, String company);

  Future<String> addFileToFirebase(Project project,String company, File file);

  Future<String> getDownloadURL(Project project,String company, File file);

  Future<void> addData(Project project, String company, List<DataPoint> data);

  Future<List<DataPoint>> getData(Project project, String company);
   Future<void> updateDataPoint(DataPoint dp, Project project, String company);

     Future<void> deleteProject(Project project, String company, List<String> id);


}