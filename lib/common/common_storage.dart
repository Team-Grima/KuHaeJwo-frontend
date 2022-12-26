import 'package:get_storage/get_storage.dart';

import 'package:pet_app/common/service_response.dart';

class CommonStorageKey {
  static const String userAlertSettings = 'userAlertSettings';
  static const String userAgreeALL = 'userAgreeALL';
  static const String userFCMToken = 'userFCMToken';
  static const String userId = 'userId';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  deleteAll() {
    GetStorage().erase();
  }
}

extension StringExtension on String {
  ServiceResponse get read {
    var value = GetStorage().read(this);
    if (value == null || value == '') {
      return ServiceResponse(result: false, errorMsg: "저장되지 않은 파일");
    } else {
      return ServiceResponse(result: true, value: GetStorage().read(this));
    }
  }

  Future<void> write(dynamic? value) {
    return GetStorage().write(this, value);
  }
}
