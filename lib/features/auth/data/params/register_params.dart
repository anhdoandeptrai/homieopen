class RegisterParams {
  final String fullname;
  final String phone;
  final String password;
  final String passwordConfirmation;
  RegisterParams({
    required this.fullname,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullname": fullname,
      "phone": phone,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }
}
