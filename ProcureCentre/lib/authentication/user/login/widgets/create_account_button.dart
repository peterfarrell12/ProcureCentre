import 'package:ProcureCentre/authentication/company/company_login/company_login_screen.dart';
import 'package:ProcureCentre/authentication/company/company_repository.dart';

import 'package:flutter/material.dart';

import '../../user_repository.dart';



class CreateAccountButton extends StatelessWidget {
  final CompanyRepository _companyRepository;
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required CompanyRepository companyRepository, @required UserRepository userRepository})
      : assert(companyRepository != null && userRepository != null),
        _companyRepository = companyRepository,
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return CompanyLoginScreen(companyRepository: _companyRepository, userRepository: _userRepository,);
          }),
        );
      },
    );
  }
}