part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
}

class LoadData extends HomeScreenEvent {
  final String company;

  const LoadData(this.company);

  @override
  List<Object> get props => [company];

  @override
  String toString() => 'Load Projects {company: $company}';
}