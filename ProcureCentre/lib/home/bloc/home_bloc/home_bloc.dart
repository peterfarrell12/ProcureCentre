import 'package:ProcureCentre/authentication/models/user.dart';
import 'package:ProcureCentre/home/bloc/home_bloc/home_event.dart';
import 'package:ProcureCentre/home/bloc/home_bloc/home_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final User _user;

  HomeBloc({@required User user})
      : assert(user != null),
        _user = user;

  @override
  HomeState get initialState => HomeScreen1State(_user, "Home");


  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is ProjectButtonPressed) {
      yield* _mapProjectButtonPressedToState(event.currentUser);
    } else if (event is HomeButtonPressed) {
      yield* _mapDashboardButtonPressedToState(event.currentUser);
    } else if (event is SettingsButtonPressed) {
      yield* _mapSettingButtonPressedToState(event.currentUser);
    } 
  }

  Stream<HomeState> _mapProjectButtonPressedToState(User user) async* {
    yield  ProjectState(user, "Project");
    
  }

  Stream<HomeState> _mapDashboardButtonPressedToState(User user) async* {
   yield  HomeScreen1State(user, "Home");
  }

    Stream<HomeState> _mapSettingButtonPressedToState(User user) async* {
    yield  SettingsState(user, "Settings");
  }

}

