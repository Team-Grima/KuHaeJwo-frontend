class UserAuthInfo {
  final dynamic mobileNumber;
  final String? name;
  final String? email;
  final dynamic emailAuth;
  final dynamic dormitory;

  UserAuthInfo({
    this.mobileNumber,
    this.name,
    this.email,
    this.emailAuth,
    this.dormitory,
  });

  UserAuthInfo.fromJson(Map<String, dynamic> json)
      : mobileNumber = json['mobileNumber'],
        name = json['name'] as String?,
        email = json['email'] as String?,
        emailAuth = json['emailAuth'],
        dormitory = json['dormitory'];

  Map<String, dynamic> toJson() => {'mobileNumber': mobileNumber, 'name': name, 'email': email, 'emailAuth': emailAuth, 'dormitory': dormitory};
}
