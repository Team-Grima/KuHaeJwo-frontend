class GetUserResponse {
  final int? id;
  final UserInfoDetailResponse? userInfoDetailResponse;
  final UserBasicInfoResponse? userBasicInfoResponse;
  final MateOfferResponse? mateOfferResponse;
  final UserPreferResponse? userPreferResponse;
  final dynamic mobileNumber;
  final String? name;
  final String? email;
  final dynamic emailAuth;
  final dynamic dormitory;

  GetUserResponse({
    this.id,
    this.userInfoDetailResponse,
    this.userBasicInfoResponse,
    this.mateOfferResponse,
    this.userPreferResponse,
    this.mobileNumber,
    this.name,
    this.email,
    this.emailAuth,
    this.dormitory,
  });

  GetUserResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userInfoDetailResponse = (json['userInfoDetailResponse'] as Map<String, dynamic>?) != null
            ? UserInfoDetailResponse.fromJson(json['userInfoDetailResponse'] as Map<String, dynamic>)
            : null,
        userBasicInfoResponse = (json['userBasicInfoResponse'] as Map<String, dynamic>?) != null
            ? UserBasicInfoResponse.fromJson(json['userBasicInfoResponse'] as Map<String, dynamic>)
            : null,
        mateOfferResponse =
            (json['mateOfferResponse'] as Map<String, dynamic>?) != null ? MateOfferResponse.fromJson(json['mateOfferResponse'] as Map<String, dynamic>) : null,
        userPreferResponse = (json['userPreferResponse'] as Map<String, dynamic>?) != null
            ? UserPreferResponse.fromJson(json['userPreferResponse'] as Map<String, dynamic>)
            : null,
        mobileNumber = json['mobileNumber'],
        name = json['name'] as String?,
        email = json['email'] as String?,
        emailAuth = json['emailAuth'],
        dormitory = json['dormitory'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userInfoDetailResponse': userInfoDetailResponse?.toJson(),
        'userBasicInfoResponse': userBasicInfoResponse?.toJson(),
        'mateOfferResponse': mateOfferResponse?.toJson(),
        'userPreferResponse': userPreferResponse?.toJson(),
        'mobileNumber': mobileNumber,
        'name': name,
        'email': email,
        'emailAuth': emailAuth,
        'dormitory': dormitory
      };
}

class UserInfoDetailResponse {
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

  UserInfoDetailResponse({
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

  UserInfoDetailResponse.fromJson(Map<String, dynamic> json)
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

class UserBasicInfoResponse {
  final String? college;
  final String? department;
  final String? studentId;
  final int? age;
  final String? mbti;
  final String? gender;

  UserBasicInfoResponse({
    this.college,
    this.department,
    this.studentId,
    this.age,
    this.mbti,
    this.gender,
  });

  UserBasicInfoResponse.fromJson(Map<String, dynamic> json)
      : college = json['college'] as String?,
        department = json['department'] as String?,
        studentId = json['studentId'] as String?,
        age = json['age'] as int?,
        mbti = json['mbti'] as String?,
        gender = json['gender'] as String?;

  Map<String, dynamic> toJson() => {'college': college, 'department': department, 'studentId': studentId, 'age': age, 'mbti': mbti, 'gender': gender};
}

class MateOfferResponse {
  final int? id;
  final String? title;
  final String? dormitoryName;
  final String? body;
  final bool? matching;
  final int? goodnessOfFit;
  final UserProfile? userProfile;

  MateOfferResponse({
    this.id,
    this.title,
    this.dormitoryName,
    this.body,
    this.matching,
    this.goodnessOfFit,
    this.userProfile,
  });

  MateOfferResponse.fromJson(Map<String, dynamic> json)
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

class UserPreferResponse {
  final List<String>? preferList;

  UserPreferResponse({
    this.preferList,
  });

  UserPreferResponse.fromJson(Map<String, dynamic> json) : preferList = (json['preferList'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {'preferList': preferList};
}
