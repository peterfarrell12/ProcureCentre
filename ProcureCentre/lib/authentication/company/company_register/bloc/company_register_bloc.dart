import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../validators.dart';
import '../../company_repository.dart';
import 'bloc.dart';

class CompanyRegisterBloc extends Bloc<CompanyRegisterEvent, CompanyRegisterState> {
  final CompanyRepository _companyRepository;

  CompanyRegisterBloc({@required CompanyRepository companyRepository})
      : assert(companyRepository != null),
        _companyRepository = companyRepository;

  @override
  CompanyRegisterState get initialState => CompanyRegisterState.empty();

  @override
  Stream<CompanyRegisterState> transformEvents(
    Stream<CompanyRegisterEvent> events,
    Stream<CompanyRegisterState> Function(CompanyRegisterEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! CompanyNameChanged && event is! CompanyPinChanged && event is! CompanyAbbChanged);
    });
    final debounceStream = events.where((event) {
      return (event is CompanyNameChanged || event is CompanyPinChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<CompanyRegisterState> mapEventToState(
    CompanyRegisterEvent event,
  ) async* {
    if (event is CompanyPinChanged) {
      yield* _mapCompanyPinChangedToState(event.pin);
    } else if (event is CompanyAbbChanged) {
      yield* _mapCompanyAbbChangedToState(event.abb);
    } else if (event is CompanySubmitted) {
      yield* _mapFormSubmittedToState(
          event.name, event.pin, event.abb);
    }
  }


  Stream<CompanyRegisterState> _mapCompanyPinChangedToState(String pin) async* {
    yield state.update(
      isPINValid: Validators.isValidPin(pin),
    );
  }

  Stream<CompanyRegisterState> _mapCompanyAbbChangedToState(
      String abb) async* {
    yield state.update(
      isAbbValid: Validators.isValidAbb(abb),
    );
  }

  Stream<CompanyRegisterState> _mapFormSubmittedToState(
      String name, String pin, String abb) async* {
    yield CompanyRegisterState.loading();
    try {
       _companyRepository.createCompany(name, pin, abb);
      yield CompanyRegisterState.success();
    } catch (_) {
      yield CompanyRegisterState.failure();
    }
  }
}
