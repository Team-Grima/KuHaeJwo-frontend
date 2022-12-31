import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/service/auth_service.dart';
import 'package:pet_app/common/utils/service_response.dart';
import 'package:pet_app/pages/home/home_view_page.dart';
import 'package:pet_app/common/utils/email_format_helper.dart';

class SchoolAuthController extends GetxController {
  bool isLoading = false;

  var isIdSave = false.obs;
  var isAutoLogin = true.obs;
  bool isAndroid = false;

  final isEmailValid = true.obs;
  final emailWarning = ''.obs;
  final TextEditingController emailController = TextEditingController();

  void toggleAutoLogin() {
    isAutoLogin.value = !isAutoLogin.value;
  }

  void toggleIdSave() {
    isIdSave.value = !isIdSave.value;
  }

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

  void submit() async {
    // Get.offAllNamed(HomeViewPage.url);
    try {
      if (emailController.text.isEmpty) {
        isLoading = false;
        return;
      }

      var email = emailController.text.trim();
      ServiceResponse res = await AuthService().login(email, email).load();
      isLoading = false;
      if (res.result) {
        Get.offAllNamed(HomeViewPage.url);
      } else {
        // Common.showSnackbar(message: res.errorMsg);
        Get.dialog(
          Common.commonModal(
            mainText: res.errorMsg == "Connection refused" ? "서버 연결 실패" : '로그인 오류',
            subText: res.errorMsg == "Connection refused" ? "관리자에게 문의해주세요." : '올바른 아이디(이메일) 또는 비밀번호를 입력하세요.',
            button1Color: CommonColor.mainMidGreen,
            button1TextColor: CommonColor.white,
            button1Text: '확인',
            numberOfButton: 1,
          ),
        );
        // await Get.defaultDialog(title: "로그인 실패", middleText: res.errorMsg);
      }
    } catch (e) {
      // _setLog.setCrashLog(Routes.signInViewRoute, "submit", e.toString());
    }
  }
}
