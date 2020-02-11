import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../projects_repository.dart';
import '../blocs.dart';


class ProjectsBloc extends Bloc<ProjectEvent, ProjectsState> {
  final ProjectRepository _projectsRepository;
  StreamSubscription _projectsSubscription;

  ProjectsBloc({@required ProjectRepository projectsRepository})
      : assert(projectsRepository != null),
        _projectsRepository = projectsRepository;

  @override
  ProjectsState get initialState => ProjectsLoading();

  @override
  Stream<ProjectsState> mapEventToState(ProjectEvent event) async* {
    if (event is LoadProjects) {
      yield* _mapLoadProjectsToState(event);
    } else if (event is AddProject) {
      yield* _mapAddProjectToState(event);
    } else if (event is UpdateProject) {
      yield* _mapUpdateProjectToState(event);
    } else if (event is DeleteProject) {
      yield* _mapDeleteProjectToState(event);
    } else if (event is ProjectsUpdated) {
      yield* _mapProjectsUpdateToState(event);
    }
    else if (event is AddProjectFile) {
      yield* _mapAddNewFileToState(event);
    }
  }

   Stream<ProjectsState> _mapLoadProjectsToState(LoadProjects event) async* {
    _projectsSubscription?.cancel();
     _projectsRepository.listenToProjectsRealTime(event.company).listen(
          (projects) => add(ProjectsUpdated(projects)),
        );
  }

  Stream<ProjectsState> _mapAddProjectToState(AddProject event) async* {
    _projectsRepository.addNewProject(event.project, event.company);
  }

  Stream<ProjectsState> _mapUpdateProjectToState(UpdateProject event) async* {
    _projectsRepository.updateProject(event.updatedProject, event.company);
  }

  Stream<ProjectsState> _mapDeleteProjectToState(DeleteProject event) async* {
    _projectsRepository.deleteProject(event.project, event.company);
  }


  Stream<ProjectsState> _mapProjectsUpdateToState(ProjectsUpdated event) async* {
    yield ProjectsLoaded(event.projects);
  }

  Stream<ProjectsState> _mapAddNewFileToState(AddProjectFile event) async* {
   _projectsRepository.addNewProjectFile(event.project, event.company, event.file);
  }

  @override
  Future<void> close() {
    _projectsSubscription?.cancel();
    return super.close();
  }
}