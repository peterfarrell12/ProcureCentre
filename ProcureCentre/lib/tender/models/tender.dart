import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/tender/entities/tender_entity.dart';
import 'package:meta/meta.dart';

@immutable
class Tender {
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

  Tender(
      {this.user = '',
      String title = '',
      String projectName = '',
      String id,
      String scope = '',
      String company = '',
      DateTime created,
      List<String> categories,
      int length,
      List<String> dPReferences})
      : this.projectName = projectName ?? '',
        this.id = id,
        this.title = title,
        this.scope = scope ?? '',
        this.company = company ?? '',
        this.created = created,
        this.categories = categories,
        this.length = length,
        this.dPReferences = dPReferences;

  Tender copyWith(
      {String id,
      String title,
      String projectName,
      String user,
      String scope,
      String company,
      DateTime created,
      int length,
      List<String> dPReferences,
      List<String> categories}) {
    return Tender(
        id: id ?? this.id,
        title: title ?? this.title,
        projectName: projectName ?? this.projectName,
        scope: scope ?? this.scope,
        created: created ?? this.created,
        company: company ?? this.company,
        length: length ?? this.length,
        dPReferences: dPReferences ?? this.dPReferences,
        categories: categories ?? this.categories);
  }

  @override
  int get hashCode =>
      company.hashCode ^
      title.hashCode^
      user.hashCode ^
      projectName.hashCode ^
      id.hashCode ^
      scope.hashCode ^
      created.hashCode ^
      length.hashCode ^
      dPReferences.hashCode ^
      categories.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tender &&
          runtimeType == other.runtimeType &&
          company == other.company &&
          user == other.user &&
          projectName == other.projectName &&
          id == other.id &&
          scope == other.id &&
          created == other.created &&
          length == other.length &&
          dPReferences == other.dPReferences &&
          categories == other.categories;

  @override
  String toString() {
    return 'Tender{title: $title, company: $company, user: $user, projectName: $projectName, id: $id, scope: $scope, created: $created}';
  }

  TenderEntity toEntity() {
    return TenderEntity(user,title, id, projectName, scope, company, categories,
        created, length, dPReferences);
  }

  static Tender fromEntity(TenderEntity entity) {
    return Tender(
      user: entity.user,
      title: entity.title,
      company: entity.company,
      projectName: entity.projectName,
      id: entity.id,
      scope: entity.scope,
      created: entity.created,
      length: entity.length,
      categories: entity.categories as List<String>,
      dPReferences: entity.dPReferences as List<String>,
      //data: entity.data,
    );
  }
}
