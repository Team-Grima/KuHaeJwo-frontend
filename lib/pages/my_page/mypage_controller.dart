import 'package:cross_file/cross_file.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';

import 'package:pet_app/common/service/auth_service.dart';

class MyPageController extends GetxController {
  AuthService authService = AuthService();
  changeProfile() async {
    XFile? profile = await Common().onAddTap();
    if (profile != null) {
      var res = await authService.updateUserProfile(profile);
      if (res) {
      } else {
        Common.showSnackbar(message: "error");
      }
    }
  }
}
