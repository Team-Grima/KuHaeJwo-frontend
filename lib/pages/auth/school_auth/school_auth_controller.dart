import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_app/common/common.dart';

import 'package:get/get.dart';
import '../../../common/service/auth_service.dart';
import '../../../common/utils/email_format_helper.dart';

class SchoolAuthController extends GetxController {
  bool isLoading = false;
  bool isAndroid = false;

  final isEmailValid = true.obs;
  final emailWarning = ''.obs;
  final TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    isAndroid = Platform.isAndroid;
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void emailControllerListener() {
    if (!EmailFormatHelper.isEmailValid(emailController.text.trim()) || emailController.text.isEmpty) {
      emailWarning.value = '올바른 이메일 형식이 아닙니다.';
      isEmailValid.value = false;
    } else {
      emailWarning.value = '';
      isEmailValid.value = true;
    }
  }

  void emailAuth() async {
    // Get.offAllNamed(HomeViewPage.url);
    try {
      emailControllerListener();
      if (!isEmailValid.value) {
        isLoading = false;
        return;
      }

      var email = emailController.text.trim();
      var parsingEmail = email.split("@")[0];
      bool? res = await AuthService().sendConfirmEmail(email: parsingEmail).load();
      isLoading = false;
      if (res) {
        Get.toNamed("/email-auth", arguments: email);
      } else {
        emailWarning.value = '인증 오류. 관리자에게 문의해주세요';
      }
    } catch (e) {
      // _setLog.setCrashLog(Routes.signInViewRoute, "submit", e.toString());
    }
  }
}
