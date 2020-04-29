import 'dart:html';

import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:ProcureCentre/tender/models/tender.dart';



abstract class TenderRepository {

  //Future<void> isTenderComplete(Project project, String company);

  //Future<void> getTenderData(Project project, String company);



  Future<void> addTender(Project project, String company, Tender tender);

  Future<List<Tender>> getTenders(Project project, String company);


   Future<void> updateTender(Tender tender, Project project, String company);

   Future<int> getLength(Project project, String company);

   Future<List<DataPoint>> getDataPoints(Project project, String company, List<String> ids);

}