import 'package:equatable/equatable.dart';
import 'package:firebase/firestore.dart' as fs;

class ProjectEntity extends Equatable {
  final bool complete;
  final String id;
  final String name;
  final String user;
  final String description;
  final DateTime created;
  final String status;
  final List<String> teamMembers;
  final Map<String, dynamic> fileNames;
  final Map<String, dynamic> extraction;
  final Map<String, dynamic> classification;
  final Map<String, dynamic> dashboard;
  final Map<String, dynamic> tenderCreation;

  const ProjectEntity(
      this.user,
      this.id,
      this.name,
      this.complete,
      this.description,
      this.created,
      this.status,
      this.teamMembers,
      this.fileNames,
      this.extraction,
      this.classification,
      this.dashboard,
      this.tenderCreation);

  Map<String, Object> toJson() {
    return {
      "Completed": complete,
      "User": user,
      "Name": name,
      "Description": description,
      "Created": created,
      "Status": status,
      "Team Members": teamMembers,
      "Files": fileNames,
      "Extraction": extraction,
      "Classification": classification,
      "Dashboard": dashboard,
      "Tender Creation": tenderCreation
    };
  }

  @override
  List<Object> get props => [
        complete,
        user,
        name,
        description,
        created,
        status,
        teamMembers,
        fileNames,
        extraction,
        classification,
        dashboard,
        tenderCreation
      ];

  @override
  String toString() {
    return 'ProjectEntity{complete: $complete, user: $user, name: $name, id: $id, description: $description, created: $created, status: $status}';
  }

  static ProjectEntity fromJson(Map<String, Object> json) {
    return ProjectEntity(
      json["User"] as String,
      json["id"] as String,
      json["Name"] as String,
      json["Completed"] as bool,
      json["Description"] as String,
      json["Created"] as DateTime,
      json["Status"] as String,
      json["Team Members"] as List<String>,
      json["Files"] as Map<String, dynamic>,
      json["Extraction"] as Map<String, dynamic>,
      json["Classification"] as Map<String, dynamic>,
      json["Dashboard"] as Map<String, dynamic>,
      json["Tender Creation"] as Map<String, dynamic>,
    );
  }

  static ProjectEntity fromSnapshot(fs.DocumentSnapshot snap) {
    return ProjectEntity(
      snap.data()['User'],
      snap.id,
      snap.data()['Name'],
      snap.data()['Completed'],
      snap.data()['Description'],
      snap.data()['Created'],
      snap.data()['Status'],
      snap.data()['Team Members'],
      snap.data()['Files'],
      snap.data()['Extraction'],
      snap.data()['Classification'],
      snap.data()['Dashboard'],
      snap.data()['Tender Creation'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "Completed": complete,
      "User": user,
      "Name": name,
      "Description": description,
      "Created": created,
      "Status": status,
      "Team Members": teamMembers,
      "Files": fileNames,
      "Extraction": extraction,
      "Classification": classification,
      "Dashboard": dashboard,
      "Tender Creation": tenderCreation
    };
  }
}
