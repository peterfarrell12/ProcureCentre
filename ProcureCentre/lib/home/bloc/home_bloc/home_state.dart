import 'package:ProcureCentre/authentication/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

    @override
  List<Object> get props => [];
}


class ProjectState extends HomeState {
final User user;
final String selected;

  const ProjectState(this.user, this.selected);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated { User: $user }';

}

class HomeScreen1State extends HomeState {
 final User user;
 final String selected;


  const HomeScreen1State(this.user, this.selected);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated { User: $user }';

}

class SettingsState extends HomeState {
  final User user;
  final String selected;


  const SettingsState(this.user, this.selected);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated { User: $user }';

}
