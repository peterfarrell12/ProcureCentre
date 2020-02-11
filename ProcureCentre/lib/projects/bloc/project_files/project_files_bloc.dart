import 'dart:async';
import 'package:ProcureCentre/projects/bloc/project_files/project_files_event.dart';
import 'package:ProcureCentre/projects/bloc/project_files/project_files_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../projects_repository.dart';
import '../blocs.dart';


class ProjectFilesBloc extends Bloc<ProjectFilesEvent, ProjectFilesState> {
  final ProjectRepository _projectFilesRepository;
  StreamSubscription _projectFilesSubscription;

  ProjectFilesBloc({@required ProjectRepository projectFilesRepository})
      : assert(projectFilesRepository != null),
        _projectFilesRepository = projectFilesRepository;

  @override
  ProjectFilesState get initialState => ProjectFilesLoading();

  @override
  Stream<ProjectFilesState> mapEventToState(ProjectFilesEvent event) async* {
    if (event is LoadProjectFiles) {
      yield* _mapLoadProjectFilesToState(event);
    } else if (event is AddProjectFiles) {
      yield* _mapAddProjectToState(event);
    } 
    else if (event is UpdateProject) {
      yield* _mapUpdateProjectToState(event);
    } 
    else if (event is DeleteProject) {
      yield* _mapDeleteProjectToState(event);
    } else if (event is ProjectFilesUpdated) {
      yield* _mapProjectFilesUpdateToState(event);
    }
  }

   Stream<ProjectFilesState> _mapLoadProjectFilesToState(LoadProjectFiles event) async* {
    _projectFilesSubscription?.cancel();
     _projectFilesRepository.listenToProjectFilesRealTime(event.company, event.project, ).listen(
          (projectFiles) => add(ProjectFilesUpdated(projectFiles)),
        );
  }

  Stream<ProjectFilesState> _mapAddProjectToState(AddProjectFiles event) async* {
    _projectFilesRepository.addNewProjectFile(event.project, event.company, event.file);
  }

  Stream<ProjectFilesState> _mapUpdateProjectToState(UpdateProjectFiles event) async* {
    _projectFilesRepository.updateProjectFiles(event.updatedProject, event.company, event.file);
  }

  Stream<ProjectFilesState> _mapDeleteProjectToState(DeleteProjectFiles event) async* {
    _projectFilesRepository.deleteProjectFile(event.project, event.company, event.file);
  }


  Stream<ProjectFilesState> _mapProjectFilesUpdateToState(ProjectFilesUpdated event) async* {
    yield ProjectFilesLoaded(event.projectFiles);
  }

  @override
  Future<void> close() {
    _projectFilesSubscription?.cancel();
    return super.close();
  }
}