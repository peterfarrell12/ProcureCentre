class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
   static final RegExp _pinRegExp = RegExp(
    r'^[0-9]{4}$',

  );
   static final RegExp _abbRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{3,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

    static isValidDisplayName(String displayName) {
    return _passwordRegExp.hasMatch(displayName);
  }

    static isValidPin(String pin) {
    return _pinRegExp.hasMatch(pin);
  }

    static isValidAbb(String abb) {
    return _abbRegExp.hasMatch(abb);
  }
}