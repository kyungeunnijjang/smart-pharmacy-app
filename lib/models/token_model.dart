class TokenModel {
  final String access;
  final String refresh;

  TokenModel.fromJson(Map<String, dynamic> json)
      : access = json['access'],
        refresh = json['refresh'];
}

class UserModel {
  final String lastLogin;
  final String username;
  final String email;
  final String dateJoined;
  final String name;

  UserModel.fromJson(Map<String, dynamic> json)
      : lastLogin = json['last_login'],
        username = json['username'],
        email = json['email'],
        dateJoined = json['data_joined'],
        name = json['name'];
}

class MedicineTinyModel {
  final int id;
  final String name;
  final String company;
  final int price;

  MedicineTinyModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        company = json['company'],
        price = json['price'];
}
