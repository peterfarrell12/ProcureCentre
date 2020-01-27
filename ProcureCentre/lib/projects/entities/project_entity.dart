
import 'package:equatable/equatable.dart';
import 'package:firebase/firestore.dart' as fs;


class ProjectEntity extends Equatable {
  final bool complete;
  final String id;
  final String name;
  final String user;

  const ProjectEntity(this.user, this.id,this.name, this.complete);

  Map<String, Object> toJson() {
    return {
      "Completed": complete,
      "User": user,
      "Name": name,

    };
  }

  @override
  List<Object> get props => [complete, name, user];

  @override
  String toString() {
    return 'ProjectEntity { completed: $complete, user: $user, name: $name, }';
  }

  static ProjectEntity fromJson(Map<String, Object> json) {
    return ProjectEntity(
      json["User"] as String,
      json["id"] as String,
      json["Name"] as String,
      json["Completed"] as bool,
    );
  }

  static ProjectEntity fromSnapshot(fs.DocumentSnapshot snap) {
    return ProjectEntity(
      snap.data()['User'],
      snap.id,
      snap.data()['Name'],
      snap.data()['Completed'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "Completed": complete,
      "User": user,
      "Name": name,
    };
  }
}