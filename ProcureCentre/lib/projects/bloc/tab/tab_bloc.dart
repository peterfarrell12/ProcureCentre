import 'dart:async';
import 'package:ProcureCentre/projects/models/models.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';


class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.projects;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}