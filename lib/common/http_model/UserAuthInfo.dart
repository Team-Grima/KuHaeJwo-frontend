class UserAuthInfo {
  final BigInt? id;
  final dynamic mobileNumber;
  final String? name;
  final String? email;
  final dynamic emailAuth;
  final dynamic dormitory;

  UserAuthInfo({
    this.id,
    this.mobileNumber,
    this.name,
    this.email,
    this.emailAuth,
    this.dormitory,
  });

  UserAuthInfo.fromJson(Map<String, dynamic> json)
      : id = BigInt.from(json['id']),
        mobileNumber = json['mobileNumber'],
        name = json['name'] as String?,
        email = json['email'] as String?,
        emailAuth = json['emailAuth'],
        dormitory = json['dormitory'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'mobileNumber': mobileNumber,
        'name': name,
        'email': email,
        'emailAuth': emailAuth,
        'dormitory': dormitory,
      };
}
