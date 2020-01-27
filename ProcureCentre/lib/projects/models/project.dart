import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Project {
  final bool complete;
  final String id;
  final String name;
  final String user;

  Project(this.user, {this.complete = false, String name = '', String id})
      : this.name = name ?? '',
        this.id = id;

  Project copyWith({bool complete, String id, String name, String user}) {
    return Project(
      user ?? this.user,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  int get hashCode =>
      complete.hashCode ^ user.hashCode ^ name.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          user == other.user &&
          name == other.name &&
          id == other.id;

  @override
  String toString() {
    return 'Project{complete: $complete, user: $user, name: $name, id: $id}';
  }

  ProjectEntity toEntity() {
    return ProjectEntity(user,id, name, complete);
  }

  static Project fromEntity(ProjectEntity entity) {
    return Project(
      entity.user,
      complete: entity.complete ?? false,
      name: entity.name,
      id: entity.id,
    );
  }
}