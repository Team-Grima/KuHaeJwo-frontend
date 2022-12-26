class GetMateOfferListResponse {
  final bool? success;
  final int? code;
  final String? msg;
  final List<UserDetailData>? data;

  GetMateOfferListResponse({
    this.success,
    this.code,
    this.msg,
    this.data,
  });

  GetMateOfferListResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        code = json['code'] as int?,
        msg = json['msg'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => UserDetailData.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'success': success, 'code': code, 'msg': msg, 'data': data?.map((e) => e.toJson()).toList()};
}

class UserDetailData {
  final int? id;
  final String? title;
  final String? dormitoryName;
  final String? body;
  final bool? matching;
  final int? goodnessOfFit;
  final UserProfile? userProfile;

  UserDetailData({
    this.id,
    this.title,
    this.dormitoryName,
    this.body,
    this.matching,
    this.goodnessOfFit,
    this.userProfile,
  });

  UserDetailData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        dormitoryName = json['dormitoryName'] as String?,
        body = json['body'] as String?,
        matching = json['matching'] as bool?,
        goodnessOfFit = json['goodnessOfFit'] as int?,
        userProfile = (json['userProfile'] as Map<String, dynamic>?) != null ? UserProfile.fromJson(json['userProfile'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'dormitoryName': dormitoryName,
        'body': body,
        'matching': matching,
        'goodnessOfFit': goodnessOfFit,
        'userProfile': userProfile?.toJson()
      };
}

class UserProfile {
  final String? department;
  final int? age;
  final int? userId;

  UserProfile({
    this.department,
    this.age,
    this.userId,
  });

  UserProfile.fromJson(Map<String, dynamic> json)
      : department = json['department'] as String?,
        age = json['age'] as int?,
        userId = json['userId'] as int?;

  Map<String, dynamic> toJson() => {'department': department, 'age': age, 'userId': userId};
}
