import 'package:ProcureCentre/authentication/company/company_login/company_login_screen.dart';
import 'package:ProcureCentre/authentication/user/register/screens/register_screen.dart';
import 'package:ProcureCentre/authentication/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bloc/company_register_bloc.dart';
import 'bloc/company_register_event.dart';
import 'bloc/company_register_state.dart';



class CompanyRegisterForm extends StatefulWidget {
   final UserRepository _userRepository;

  CompanyRegisterForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  State<CompanyRegisterForm> createState() => _CompanyRegisterFormState();
}

class _CompanyRegisterFormState extends State<CompanyRegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
    final TextEditingController _abbController = TextEditingController();


  CompanyRegisterBloc _companyRegisterBloc;

  UserRepository get _userRepository => widget._userRepository;


  bool get isPopulated =>
      _nameController.text.isNotEmpty && _pinController.text.isNotEmpty && _abbController.text.isNotEmpty;

  bool isCompanyRegisterButtonEnabled(CompanyRegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _companyRegisterBloc = BlocProvider.of<CompanyRegisterBloc>(context);
    _nameController.addListener(_onCompanyNameChanged);
    _pinController.addListener(_onPINChanged);
    _abbController.addListener(_onAbbChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyRegisterBloc, CompanyRegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(userRepository: _userRepository, companyName: _nameController.text);
          }));
 
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Company Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<CompanyRegisterBloc, CompanyRegisterState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 50,),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.backup,
                                      size: 50,
                                      color: Theme.of(context).primaryColor),
                                ),
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 50,
                                          color: Theme.of(context).primaryColor),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "Procure",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: "Centre",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic))
                                      ]),
                                ),
                              ],
                            ),
                          )),
                       TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.verified_user),
                      labelText: 'Company Name',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autovalidate: true,
                    // validator: (_) {
                    //   return !state.isDisplayNameValid ? 'Invalid Display NAme' : null;
                    // },
                  ),
                  TextFormField(
                    controller: _abbController,
                    decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.book),
                      labelText: 'Abbrehviation',
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    autovalidate: true,
                    obscureText: false,
                    validator: (_) {
                      return !state.isAbbValid ? 'Invalid Abbrehviation' : null;
                    },
                  ),
                  TextFormField(
                    controller: _pinController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Company PIN',
                    ),
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isPINValid ? 'Invalid PIN' : null;
                    },
                  ),
                  FlatButton(
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    } ,
                    child: Text("Back To Login"),
                  ),
                  CompanyRegisterButton(
                    onPressed: isCompanyRegisterButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pinController.dispose();
    _abbController.dispose();

    super.dispose();
  }

  void _onAbbChanged() {
    _companyRegisterBloc.add(
      CompanyAbbChanged(abb: _abbController.text),
    );
  }

  void _onPINChanged() {
    _companyRegisterBloc.add(
      CompanyPinChanged(pin: _pinController.text),
    );
  }

    void _onCompanyNameChanged() {
    _companyRegisterBloc.add(
      CompanyNameChanged(name: _nameController.text),
    );
  }


  void _onFormSubmitted() {
    _companyRegisterBloc.add(
      CompanySubmitted(
        name: _nameController.text,
        pin: _pinController.text,
        abb: _abbController.text,
      ),
    );
  }
}

class CompanyRegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  CompanyRegisterButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: _onPressed,
      child: Text('Register Company'),
    );
  }
}