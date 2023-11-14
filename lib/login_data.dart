class LoginData {
  String username;
  String password;

  LoginData({this.username = '', this.password = ''});

  LoginData copyWith({String? username, String? password}) {
    return LoginData(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
