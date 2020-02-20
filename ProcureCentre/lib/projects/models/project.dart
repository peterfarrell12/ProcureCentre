
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Project {
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


  Project(this.user, {this.complete = false, 
  String name = '', String id, String description = '', DateTime created, String status = '',
  List<String> teamMembers, Map<String, dynamic> fileNames, Map<String, dynamic> extraction,
   Map<String, dynamic> classification,
  Map<String, dynamic> dashboard,
   Map<String, dynamic> tenderCreation })
      : this.name = name ?? '',
        this.id = id,
        this.description = description ?? '',
        this.created = created,
        this.status = status ?? '',
        this.teamMembers = teamMembers,
        this.fileNames = fileNames,
        this.extraction = extraction ?? {},
        this.dashboard = dashboard ?? {},
        this.tenderCreation = tenderCreation ?? {},
        this.classification = classification ?? {};
        

  Project copyWith({bool complete, String id, String name, String user, String description, DateTime created, String status,
  List<String> teamMembers,Map<String, dynamic> fileNames, Map<String, dynamic> extraction,
   Map<String, dynamic> classification,
  Map<String, dynamic> dashboard,
   Map<String, dynamic> tenderCreation,
  }) {
    return Project(
      user ?? this.user,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      created: created ?? this.created,
      status: status ?? this.status,
      teamMembers: teamMembers ?? this.teamMembers,
      fileNames: fileNames ?? this.fileNames,
      extraction: extraction ?? this.extraction,
      classification: classification ?? this.classification,
      dashboard: dashboard ?? this.dashboard,
      tenderCreation: tenderCreation ?? this.tenderCreation,
          

    );
  }

  @override
  int get hashCode =>
      complete.hashCode ^ user.hashCode ^ name.hashCode ^ id.hashCode ^ description.hashCode ^ created.hashCode ^status.hashCode ^teamMembers.hashCode  ^fileNames.hashCode ^extraction.hashCode^ classification.hashCode ^dashboard.hashCode ^tenderCreation.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          user == other.user &&
          name == other.name &&
          id == other.id &&
          description == other.id &&
          created == other.created &&
          status == other.status &&
          teamMembers == other.teamMembers &&
          fileNames == other.fileNames &&
          classification == other.classification &&
          extraction == other.extraction &&
          dashboard == other.dashboard &&
          tenderCreation == other.tenderCreation;


  @override
  String toString() {
    return 'Project{complete: $complete, user: $user, name: $name, id: $id, description: $description, created: $created, status: $status}';
  }

  ProjectEntity toEntity() {
    return ProjectEntity(user,id, name, complete, description, created, status, teamMembers,  fileNames, classification, extraction, dashboard, tenderCreation);
  }

  static Project fromEntity(ProjectEntity entity) {
    return Project(
      entity.user,
      complete: entity.complete ?? false,
      name: entity.name,
      id: entity.id,
      description: entity.description,
      created: entity.created,
      status: entity.status,
      teamMembers: entity.teamMembers,
      fileNames: entity.fileNames,
      extraction: entity.extraction,
      classification: entity.classification,
      dashboard: entity.dashboard,
      tenderCreation: entity.tenderCreation,
      //data: entity.data,

    );
  }
}