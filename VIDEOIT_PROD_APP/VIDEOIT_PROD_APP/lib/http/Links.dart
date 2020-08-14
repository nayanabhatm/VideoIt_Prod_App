class Links {

  String _baseUrl = "http://localhost:8999";
  String _logIn;
  String _signUp;
  String _signUpAnonymous;

  void init() {
    _logIn = _baseUrl+"/login";
    _signUp = _baseUrl+"/signup/";
    _signUpAnonymous = _baseUrl+"/signup/anonymous";
  }

  String get getLoginUrl {
    return _logIn;
  }

  String get getSignUpUrl {
    return _signUp;
  }

  String get getSignUpAnonymousUrl {
    return _signUpAnonymous;
  }

  Map<String, String> get getSignUpUrlHeaders => {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

}