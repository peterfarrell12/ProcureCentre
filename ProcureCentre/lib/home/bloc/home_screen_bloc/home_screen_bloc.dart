import 'dart:async';

import 'package:ProcureCentre/home/home_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  @override
    final HomeRepository _homeRepository;

  HomeScreenBloc(this._homeRepository);

  HomeScreenState get initialState => HomeScreenLoading();

  @override
  Stream<HomeScreenState> mapEventToState(
    HomeScreenEvent event,
  ) async* {
    if (event is LoadData) {
      yield* _mapLoadDataToState(event);
    }
  }

    Stream<HomeScreenState> _mapLoadDataToState(LoadData event) async* {
      print('wha');
    var companyData = await _homeRepository.getCompanyData(event.company);
    yield  HomeScreenLoaded(companyData);
    
  }
}
