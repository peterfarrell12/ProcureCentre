import 'dart:async';
import 'package:ProcureCentre/authentication/company/company_login/bloc/company_login_event.dart';
import 'package:ProcureCentre/authentication/company/company_login/bloc/company_login_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../validators.dart';
import '../../company_repository.dart';


class CompanyLoginBloc extends Bloc<CompanyLoginEvent, CompanyLoginState> {
  CompanyRepository _companyRepository;

  CompanyLoginBloc({
    @required CompanyRepository companyRepository,
  })  : assert(companyRepository != null),
        _companyRepository = companyRepository;

  @override
  CompanyLoginState get initialState => CompanyLoginState.empty();

  @override
  Stream<CompanyLoginState> transformEvents(
    Stream<CompanyLoginEvent> events,
    Stream<CompanyLoginState> Function(CompanyLoginEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! CompanyNameChanged && event is! PINChanged);
    });
    final debounceStream = events.where((event) {
      return (event is CompanyNameChanged || event is PINChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<CompanyLoginState> mapEventToState(CompanyLoginEvent event) async* {
   if (event is PINChanged) {
      yield* _mapPINChangedToState(event.pin);
    } else if (event is LoginWithCompanyCredentialsPressed) {
      yield* _mapLoginWithCompanyCredentialsPressed(
        companyName: event.companyName,
        pin: event.pin
      );
    } 
    }
  

  Stream<CompanyLoginState> _mapPINChangedToState(String pin) async* {
    yield state.update(
      isPINValid: Validators.isValidPin(pin),
    );
  }


  Stream<CompanyLoginState> _mapLoginWithCompanyCredentialsPressed({
    String companyName,
    String pin,
  }) async* {
    yield CompanyLoginState.loading();
    try {
      bool check = await  _companyRepository.checkingPIN(companyName, pin);
      if (check) {
        yield CompanyLoginState.success();
      } 
      else {
        yield CompanyLoginState.failure();
      }
      
    } catch (_) {
      yield CompanyLoginState.failure();
    }
  }
}

