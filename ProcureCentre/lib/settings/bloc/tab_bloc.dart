import 'dart:async';
import 'package:ProcureCentre/settings/models/settings_tab.dart';
import 'package:bloc/bloc.dart';
import 'tab_event.dart';
import 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, SettingsTab> {
  @override
  SettingsTab get initialState => SettingsTab.todos;

  @override
  Stream<SettingsTab> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}