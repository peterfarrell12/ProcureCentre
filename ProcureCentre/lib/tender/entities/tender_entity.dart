import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase/firestore.dart' as fs;

class TenderEntity extends Equatable {
final String id;
final String title;
  final String projectName;
  final String user;
  final String scope;
  final String company;
  final List<String> categories;
  final DateTime created;
  final int length;
  final List<String> dPReferences;

  const TenderEntity(
    this.user,
    this.title,
    this.id,
    this.projectName,
    this.scope,
    this.company,
    this.categories,
    this.created,
    this.length,
    this.dPReferences,
  );

  Map<String, Object> toJson() {
    return {
      "User": user,
      'Title' : title,
      "projectName": projectName,
      "Scope": scope,
      "Created": created,
      "Company": company,
      "Categories": categories,
      "Data": dPReferences,
      "Length": length,
    };
  }

  @override
  List<Object> get props => [
        user,
        title,
        projectName,
        scope,
        created,
        company,
        categories,
        dPReferences,
        length,
        
   
      ];

  @override
  String toString() {
    return 'TenderEntity{ title: $title ,user: $user, projectName: $projectName, id: $id, description: $scope, created: $created, company: $company}';
  }

  static TenderEntity fromJson(Map<String, Object> json) {
    return TenderEntity(
      json["User"] as String,
      json['Title'] as String,
      json["id"] as String,
      json["projectName"] as String,
      json["Scope"] as String,
      json["Company"] as String,
      json["Categories"] as List<String>,
      json["Created"] as DateTime,
      json['Length'] as int,
      json["Data"] as List<String>,
    );
  }

  static TenderEntity fromSnapshot(fs.DocumentSnapshot snap) {
    return TenderEntity(
        snap.data()['User'],
        snap.data()['Title'],
        snap.id,
        snap.data()['projectName'],
        snap.data()['Scope'],
        snap.data()['Company'],
        List.from(snap.data()['Categories']),
        snap.data()['Created'],
        snap.data()['Length'],
        List.from(snap.data()['Data'])
    );
  }

  Map<String, Object> toDocument() {
    return {
      "User": user,
      "Title" : title,
      "projectName": projectName,
      "Scope": scope,
      "Created": created,
      "Company": company,
      "Categories": categories,
      "Data": dPReferences,
      "Length": length,
    };
  }
}