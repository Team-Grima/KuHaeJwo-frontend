class PostLoginResponse {
  final bool? success;
  final int? code;
  final String? msg;
  final TokenData? data;

  PostLoginResponse({
    this.success,
    this.code,
    this.msg,
    this.data,
  });

  PostLoginResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        code = json['code'] as int?,
        msg = json['msg'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null ? TokenData.fromJson(json['data'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() => {'success': success, 'code': code, 'msg': msg, 'data': data?.toJson()};
}

class TokenData {
  final String? grantType;
  final String? accessToken;
  final String? refreshToken;
  final int? accessTokenExpireDate;

  TokenData({
    this.grantType,
    this.accessToken,
    this.refreshToken,
    this.accessTokenExpireDate,
  });

  TokenData.fromJson(Map<String, dynamic> json)
      : grantType = json['grantType'] as String?,
        accessToken = json['accessToken'] as String?,
        refreshToken = json['refreshToken'] as String?,
        accessTokenExpireDate = json['accessTokenExpireDate'] as int?;

  Map<String, dynamic> toJson() =>
      {'grantType': grantType, 'accessToken': accessToken, 'refreshToken': refreshToken, 'accessTokenExpireDate': accessTokenExpireDate};
}
