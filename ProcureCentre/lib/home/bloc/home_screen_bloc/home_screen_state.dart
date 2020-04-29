part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();
    @override
  List<Object> get props => [];
}



class HomeScreenLoading extends HomeScreenState {}

class HomeScreenLoaded extends HomeScreenState {
  final Map companyData;

  const HomeScreenLoaded([this.companyData]);

  @override
  List<Object> get props => [companyData];

  @override
  String toString() => 'HomeScreenLoaded { HomeScreen: $companyData }';
}

class HomeScreenNotLoaded extends HomeScreenState {}