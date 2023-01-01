import 'dart:io';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EmailAuthController extends GetxController {
  bool isLoading = false;
  bool isAndroid = false;

  @override
  void onInit() {
    super.onInit();
    isAndroid = Platform.isAndroid;
  }

  void onEmailTap() async {
    await launchUrlString("https://outlook.office.com/mail/");
  }

  void onResendTap() {
    Get.offNamed("/school-auth");
  }
}
