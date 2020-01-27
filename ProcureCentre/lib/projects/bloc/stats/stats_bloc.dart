import 'dart:async';
import 'package:ProcureCentre/projects/bloc/projects/bloc.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StreamSubscription _todosSubscription;

  StatsBloc({ProjectsBloc todosBloc}) : assert(todosBloc != null) {
    _todosSubscription = todosBloc.listen((state) {
      if (state is ProjectsLoaded) {
        add(UpdateStats(state.projects));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      int numActive =
          event.projects.where((project) => !project.complete).toList().length;
      int numCompleted =
          event.projects.where((project) => project.complete).toList().length;
      yield StatsLoaded(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
