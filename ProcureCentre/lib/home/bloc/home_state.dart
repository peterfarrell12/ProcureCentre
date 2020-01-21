import 'package:ProcureCentre/authentication/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

    @override
  List<Object> get props => [];
}


class ProjectState extends HomeState {
final User user;

  const ProjectState(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated { User: $user }';

}

class DashboardState extends HomeState {
 final User user;

  const DashboardState(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated { User: $user }';

}

class SettingsState extends HomeState {
  final User user;

  const SettingsState(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated { User: $user }';

}
