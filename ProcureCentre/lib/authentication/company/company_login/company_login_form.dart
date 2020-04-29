import 'package:ProcureCentre/authentication/company/company_register/company_register_screen.dart';
import 'package:ProcureCentre/authentication/user/login/screens/login_screen.dart';
import 'package:ProcureCentre/authentication/user/register/screens/register_screen.dart';
import 'package:ProcureCentre/authentication/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../company_repository.dart';
import 'bloc/company_login_bloc.dart';
import 'bloc/company_login_event.dart';
import 'bloc/company_login_state.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart';

class CompanyLoginForm extends StatefulWidget {
  final UserRepository _userRepository;
  final CompanyRepository _companyRepository;

  CompanyLoginForm(
      {Key key,
      @required UserRepository userRepository,
      @required companyRepository})
      : assert(userRepository != null && companyRepository != null),
        _userRepository = userRepository,
        _companyRepository = companyRepository,
        super(key: key);

  State<CompanyLoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<CompanyLoginForm> {
  final TextEditingController _pinController = TextEditingController();

  static fs.Firestore store = firestore();
  fs.CollectionReference companyRef = store.collection("companies");
  Stream<fs.QuerySnapshot> company;
  CompanyLoginBloc _companyLoginBloc;
  String companyName;

  UserRepository get _userRepository => widget._userRepository;
  CompanyRepository get _companyRepository => widget._companyRepository;

  bool get isPopulated => _pinController.text.isNotEmpty;

  bool isLoginButtonEnabled(CompanyLoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _companyLoginBloc = BlocProvider.of<CompanyLoginBloc>(context);
    company = companyRef.get().asStream().asBroadcastStream();
    _pinController.addListener(_onPINChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyLoginBloc, CompanyLoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Incorrect PIN'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Checking PIN...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return RegisterScreen(
                  userRepository: _userRepository, companyName: companyName);
            }),
          );
        }
      },
      child: BlocBuilder<CompanyLoginBloc, CompanyLoginState>(
        builder: (context, state) {
          return Center(
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(20.0),
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
                      Column(children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * .5,
                            child: StreamBuilder<fs.QuerySnapshot>(
                                stream: company,
                                builder: (BuildContext context,
                                    AsyncSnapshot<fs.QuerySnapshot> snapshot) {
                                  if (snapshot.hasError)
                                    return new Text('Error: ${snapshot.error}');
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return new Text('Loading...');
                                    default:
                                      return FormField(
                                        builder: (FormFieldState state) {
                                          return InputDecorator(
                                            decoration: InputDecoration(
                                              labelText: 'Company Name',
                                            ),
                                            isEmpty:
                                                companyName == "Choose Company...",
                                            child: new DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                value: companyName,
                                                isDense: true,
                                                onChanged: (dynamic newValue) {
                                                  setState(() {
                                                    companyName = newValue;
                                                    state.didChange(newValue);
                                                  });
                                                },
                                                items: snapshot.data.docs.map(
                                                    (fs.DocumentSnapshot document) {
                                                  return new DropdownMenuItem(
                                                    value: document
                                                        .data()['Company Name'],
                                                    child: new Text(document
                                                        .data()['Company Name']),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                  }
                                })),
                        Divider(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _pinController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'PIN',
                          ),
                          obscureText: true,
                          autovalidate: true,
                          autocorrect: false,
                          validator: (_) {
                            return !state.isPINValid ? 'Invalid PIN' : null;
                          },
                        ),
                      ]),
                      FlatButton(
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return LoginScreen(
                                userRepository: _userRepository,
                              );
                            }),
                          );
                        },
                        child: Text("Back To Login"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            CompanyLoginButton(
                              onPressed: isLoginButtonEnabled(state)
                                  ? _onFormSubmitted
                                  : null,
                            ),
                            CreateCompanyAccountButton(
                              userRepository: _userRepository,
                              companyRepository: _companyRepository,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _onPINChanged() {
    _companyLoginBloc.add(
      PINChanged(pin: _pinController.text),
    );
  }

  void _onFormSubmitted() {
    _companyLoginBloc.add(
      LoginWithCompanyCredentialsPressed(
        companyName: companyName,
        pin: _pinController.text,
      ),
    );
  }
}

class CompanyLoginButton extends StatelessWidget {
  final VoidCallback _onPressed;

  CompanyLoginButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: _onPressed,
      child: Text('Company Login'),
    );
  }
}

class CreateCompanyAccountButton extends StatelessWidget {
  final UserRepository _userRepository;
  final CompanyRepository _companyRepository;

  CreateCompanyAccountButton(
      {Key key,
      @required UserRepository userRepository,
      @required CompanyRepository companyRepository})
      : assert(userRepository != null && companyRepository != null),
        _userRepository = userRepository,
        _companyRepository = companyRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create a Company Account',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return CompanyRegisterScreen(
              userRepository: _userRepository,
              companyRepository: _companyRepository,
            );
          }),
        );
      },
    );
  }
}
