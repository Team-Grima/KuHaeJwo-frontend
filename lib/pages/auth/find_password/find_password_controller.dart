import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/service/auth_service.dart';
import 'package:pet_app/common/utils/service_response.dart';
import 'package:pet_app/common/utils/email_format_helper.dart';

class FindPasswordController extends GetxController {
  final isEmailValid = true.obs;
  final isLoading = false.obs;
  final isSendBtnClicked = false.obs;
  final emailWarning = ''.obs;

  final isSendBtnVisible = false.obs;
  RxBool isSendPasswordBtnClicked = false.obs;
  RxBool isSendPasswordBtnActive = false.obs;
  final TextEditingController emailController = TextEditingController();

  final AuthService authService = AuthService();

  RxBool isDeleteButtonVisible = false.obs;

  @override
  void onInit() {
    isDeleteButtonVisible = false.obs;

    emailController.addListener(() {
      isDeleteButtonVisible.value = emailController.text.isNotEmpty;
      emailControllerListener();
    });
    super.onInit();
  }

  void emailControllerListener() {
    if (!EmailFormatHelper.isEmailValid(emailController.text.trim()) || emailController.text.isEmpty) {
      emailWarning.value = '올바른 이메일 형식이 아닙니다.';
      isEmailValid.value = false;
      isSendPasswordBtnActive.value = false;
    } else {
      emailWarning.value = '';
      isEmailValid.value = true;
      isSendPasswordBtnActive.value = true;
    }
  }

  Future<bool> findPWVerify() async {
    emailControllerListener();

    if (isEmailValid.value) {
      // ServiceResponse<bool> res = await AuthService().checkEmailDuplicated(emailController.text);//TODO :: 이메일 중복체크 로직 추가
      ServiceResponse<bool> res;
      res = ServiceResponse(result: false);
      if (!res.result) {
        isEmailValid.value = true;
        isSendPasswordBtnClicked.value = true;
      } else {
        isEmailValid.value = false;
        emailWarning.value = '이미 사용중인 이메일 주소예요';
      }
    }

    return (isEmailValid.value && EmailFormatHelper.isEmailValid(emailController.text.trim()));
  }
}
