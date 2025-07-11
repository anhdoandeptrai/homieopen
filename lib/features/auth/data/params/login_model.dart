class LoginModel {
  LoginModel({
    required this.accessToken,
    required this.refreshToken,
  });

  final String? accessToken;
  final String? refreshToken;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
    );
  }
}
