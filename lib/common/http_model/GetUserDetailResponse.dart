class GetUserResponse {
  final bool? success;
  final int? code;
  final String? msg;
  final DetailData? detailData;
  final UserData? userData;

  GetUserResponse({
    this.success,
    this.code,
    this.msg,
    this.detailData,
    this.userData,
  });

  GetUserResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        code = json['code'] as int?,
        msg = json['msg'] as String?,
        detailData = (json['detailData'] as Map<String, dynamic>?) != null ? DetailData.fromJson(json['detailData'] as Map<String, dynamic>) : null,
        userData = (json['data'] as Map<String, dynamic>?) != null ? UserData.fromJson(json['data'] as Map<String, dynamic>) : null;
  // userData = (json['userData'] as Map<String, dynamic>?) != null ? UserData.fromJson(json['userData'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() => {'success': success, 'code': code, 'msg': msg, 'detailData': detailData?.toJson(), 'userData': userData?.toJson()};
}

class DetailData {
  final String? cleanHabit;
  final String? washingTime;
  final String? alcohol;
  final String? smoking;
  final String? sleepingTime;
  final String? sleepingHabit;
  final String? sleeper;
  final String? wakeUpTime;
  final String? alarm;
  final String? outing;
  final String? bug;
  final String? temperature;
  final String? friend;

  DetailData({
    this.cleanHabit,
    this.washingTime,
    this.alcohol,
    this.smoking,
    this.sleepingTime,
    this.sleepingHabit,
    this.sleeper,
    this.wakeUpTime,
    this.alarm,
    this.outing,
    this.bug,
    this.temperature,
    this.friend,
  });

  DetailData.fromJson(Map<String, dynamic> json)
      : cleanHabit = json['cleanHabit'] as String?,
        washingTime = json['washingTime'] as String?,
        alcohol = json['alcohol'] as String?,
        smoking = json['smoking'] as String?,
        sleepingTime = json['sleepingTime'] as String?,
        sleepingHabit = json['sleepingHabit'] as String?,
        sleeper = json['sleeper'] as String?,
        wakeUpTime = json['wakeUpTime'] as String?,
        alarm = json['alarm'] as String?,
        outing = json['outing'] as String?,
        bug = json['bug'] as String?,
        temperature = json['temperature'] as String?,
        friend = json['friend'] as String?;

  Map<String, dynamic> toJson() => {
        'cleanHabit': cleanHabit,
        'washingTime': washingTime,
        'alcohol': alcohol,
        'smoking': smoking,
        'sleepingTime': sleepingTime,
        'sleepingHabit': sleepingHabit,
        'sleeper': sleeper,
        'wakeUpTime': wakeUpTime,
        'alarm': alarm,
        'outing': outing,
        'bug': bug,
        'temperature': temperature,
        'friend': friend
      };
}

class UserData {
  final String? college;
  final String? department;
  final String? studentId;
  final int? age;
  final dynamic mbti;
  final String? gender;

  UserData({
    this.college,
    this.department,
    this.studentId,
    this.age,
    this.mbti,
    this.gender,
  });

  UserData.fromJson(Map<String, dynamic> json)
      : college = json['college'] as String?,
        department = json['department'] as String?,
        studentId = json['studentId'] as String?,
        age = json['age'] as int?,
        mbti = json['mbti'],
        gender = json['gender'] as String?;

  Map<String, dynamic> toJson() => {'college': college, 'department': department, 'studentId': studentId, 'age': age, 'mbti': mbti, 'gender': gender};
}
