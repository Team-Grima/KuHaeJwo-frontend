class PostLoginResponse {
  final String? grantType;
  final String? accessToken;
  final String? refreshToken;
  final int? accessTokenExpireDate;

  PostLoginResponse({
    this.grantType,
    this.accessToken,
    this.refreshToken,
    this.accessTokenExpireDate,
  });

  PostLoginResponse.fromJson(Map<String, dynamic> json)
      : grantType = json['grantType'] as String?,
        accessToken = json['accessToken'] as String?,
        refreshToken = json['refreshToken'] as String?,
        accessTokenExpireDate = json['accessTokenExpireDate'] as int?;

  Map<String, dynamic> toJson() =>
      {'grantType': grantType, 'accessToken': accessToken, 'refreshToken': refreshToken, 'accessTokenExpireDate': accessTokenExpireDate};
}
