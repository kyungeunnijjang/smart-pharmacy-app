class TokenModel {
  final String access;
  final String refresh;

  TokenModel.fromJson(Map<String, dynamic> json)
      : access = json['access'],
        refresh = json['refresh'];
}

class UserModel {
  final String last_login;
  final String username;
  final String email;
  final String data_joined;
  final String name;

  UserModel.fromJson(Map<String, dynamic> json)
      : last_login = json['last_login'],
        username = json['username'],
        email = json['email'],
        data_joined = json['data_joined'],
        name = json['name'];
}
