import 'package:ProcureCentre/authentication/company/company_login/bloc/company_login_bloc.dart';
import 'package:ProcureCentre/authentication/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../company_repository.dart';
import 'company_login_form.dart';




class CompanyLoginScreen extends StatelessWidget {
  final CompanyRepository _companyRepository;
  final UserRepository _userRepository;

  CompanyLoginScreen({Key key, @required CompanyRepository companyRepository, @required UserRepository userRepository})
      : assert(companyRepository != null && userRepository != null),
        _companyRepository = companyRepository,
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CompanyLoginBloc>(
        create: (context) => CompanyLoginBloc(companyRepository: _companyRepository),
        child: Row(
          children: <Widget>[
            Container(
          width: MediaQuery.of(context).size.width * .5,
          color: Colors.blue,
          child: Center(child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 50, color: Colors.white),
              children: <TextSpan> [
                TextSpan(text: "Procure", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "Centre", style: TextStyle(fontStyle: FontStyle.italic))
              ]
            ),
          ),),
        ),
            Container(
              width: MediaQuery.of(context).size.width * .5,
              child: CompanyLoginForm(userRepository: _userRepository, companyRepository: _companyRepository,)),
          ],
        ),
              ),
            );
          }
        }