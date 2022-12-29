import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/service/auth_service.dart';
import 'package:pet_app/common/service_response.dart';
import 'package:pet_app/common/utils/email_format_helper.dart';
import 'package:pet_app/common/utils/phone_format_helper.dart';

class RegisterController extends GetxController {
  final isEmailValid = true.obs;
  final isPwdValid = true.obs;
  final isPwdCheckValid = true.obs;

  bool isEmailDuplicated = false;

  final isNameValid = true.obs;
  final isPhoneNumValid = true.obs;
  final isVerifyNumValid = true.obs;

  final primaryKey = ''.obs;

  final isTimerGoing = false.obs;
  final isLoading = false.obs;
  final isWaitingForVerification = false.obs;
  final isPhoneVerified = false.obs;
  final isSubmitActive = false.obs;

  final isSendBtnClicked = false.obs;

  final emailWarning = ''.obs;
  final nameWarning = ''.obs;
  final pwdWarning = ''.obs;
  final pwdCheckWarning = ''.obs;
  final phoneNumWarning = ''.obs;
  final verifyNumWarning = ''.obs;

  final isSendBtnVisible = false.obs;

  final isSubmitButton1Clicked = false.obs;
  final isSubmitButton2Clicked = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController pwdCheckController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController verifyNumController = TextEditingController();

  final AuthService authService = AuthService();

  Map<TextEditingController, RxBool> isDeleteButtonVisibleMap = <TextEditingController, RxBool>{};

  @override
  void onInit() {
    final textEditingControllerList = [emailController, pwdController, pwdCheckController, nameController, phoneNumController, verifyNumController];
    for (var i in textEditingControllerList) {
      isDeleteButtonVisibleMap[i] = false.obs;

      i.addListener(() {
        isDeleteButtonVisibleMap[i]!.value = i.text.isNotEmpty;
        if (i == phoneNumController) {
          if (i.text.length == 11) {
            isSendBtnVisible.value = true;
          } else {
            isSendBtnVisible.value = false;
          }
        }
        if (i == verifyNumController) {
          if (i.text.length == 6) {
            verifyStep2();
          }
        }
      });
    }

    super.onInit();
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

  void nameControllerListener() {
    if (nameController.text.isEmpty || nameController.text.length < 4) {
      nameWarning.value = '닉네임은 4자 이상이여야 합니다.';
      isNameValid.value = false;
    } else {
      nameWarning.value = '';
      isNameValid.value = true;
    }
  }

  void pwdControllerListener() {
    if (pwdController.text.isEmpty) {
      pwdWarning.value = '비밀번호를 입력해주세요';
      isPwdValid.value = false;

      return;
    }

    if (pwdController.text.length < 8) {
      pwdWarning.value = '8자리 이상의 비밀번호를 입력해주세요';
      isPwdValid.value = false;

      return;
    }

    if (pwdController.text.isNotEmpty && pwdCheckController.text.trim() != pwdController.text.trim()) {
      pwdWarning.value = '비밀번호가 일치하지 않습니다';
      isPwdValid.value = false;

      return;
    }

    pwdWarning.value = '';
    pwdCheckWarning.value = '';
    isPwdValid.value = true;
    isPwdCheckValid.value = true;
  }

  void pwdCheckControllerListener() {
    if (pwdCheckController.text.isEmpty) {
      pwdCheckWarning.value = '비밀번호를 입력해주세요';
      isPwdCheckValid.value = false;

      return;
    }

    if (pwdCheckController.text.length < 8) {
      pwdCheckWarning.value = '8자리 이상의 비밀번호를 입력해주세요';
      isPwdCheckValid.value = false;

      return;
    }

    if (pwdCheckController.text.isNotEmpty && pwdCheckController.text.trim() != pwdController.text.trim()) {
      pwdCheckWarning.value = '비밀번호가 일치하지 않습니다';
      isPwdCheckValid.value = false;

      return;
    }

    pwdWarning.value = '';
    pwdCheckWarning.value = '';
    isPwdValid.value = true;
    isPwdCheckValid.value = true;
  }

  void phoneNumControllerListener() {
    if (phoneNumController.text.isEmpty || phoneNumController.text.contains('-')) {
      phoneNumWarning.value = "'-'없이 숫자만 입력해주세요";
      isPhoneNumValid.value = false;
    } else {
      phoneNumWarning.value = '';
      isPhoneNumValid.value = true;
    }
  }

  void verifyNumControllerListener() {
    if (verifyNumController.text.isEmpty) {
      isVerifyNumValid.value = false;
    } else {
      isVerifyNumValid.value = true;
    }
  }

  bool verifyStep1() {
    emailControllerListener();
    pwdControllerListener();
    pwdCheckControllerListener();
    nameControllerListener();
    if (isEmailValid.value) {
      // ServiceResponse<bool> res = await AuthService().checkEmailDuplicated(emailController.text);//TODO :: 이메일 중복체크 로직 추가
      ServiceResponse<bool> res;
      res = ServiceResponse(result: false);
      if (!res.result) {
        isEmailDuplicated = false;
        isEmailValid.value = true;
      } else {
        isEmailDuplicated = true;
        isEmailValid.value = false;
        emailWarning.value = '이미 사용중인 이메일 주소예요';
      }
    }

    return (isPwdValid.value &&
        isNameValid.value &&
        !isEmailDuplicated &&
        isPwdCheckValid.value &&
        isEmailValid.value &&
        pwdCheckController.text.length >= 8 &&
        pwdController.text.length >= 8 &&
        EmailFormatHelper.isEmailValid(emailController.text.trim()));
  }

  bool verifyStep2() {
    nameControllerListener();
    phoneNumControllerListener();
    verifyNumControllerListener();

    return (isNameValid.value && isPhoneNumValid.value);
  }

  Future requestVerificatioNumber() async {
    try {
      if (isLoading.value) {
        return;
      }

      isLoading.value = true;

      if (!isPhoneNumValid.value) {
        isLoading.value = false;

        return;
      }

      // 인증번호 재전송 로직
      if (isWaitingForVerification.value) {
        if (true) {
          // var result = await authService.requestPhoneVerificatioNumber(phoneNumController.text.trim()); //TODO ::폰인증번호 전송로직 제외예정
          ServiceResponse result = ServiceResponse(result: true);
          if (result.result) {
            primaryKey.value = result.value ?? '';
            isWaitingForVerification.value = true;
          } else {
            primaryKey.value = '';
          }
        }
        isLoading.value = false;
        return;
      }

      if (isPhoneNumValid.value && !isWaitingForVerification.value && PhoneFormatHelper.isPhoneNumberValid(phoneNumController.text.trim())) {
        if (true) {
          isLoading.value = false;
          // var result = await authService.requestPhoneVerificatioNumber(phoneNumController.text.trim());
          ServiceResponse result = ServiceResponse(result: true);

          if (result.result) {
            primaryKey.value = result.value ?? '';
            isWaitingForVerification.value = true;
            isLoading.value = false;
          } else {
            //사용자 입력한 인증번호 틀림
            isLoading.value = false;
            primaryKey.value = '';

            Get.defaultDialog(title: '인증번호 실패', middleText: result.errorMsg);
          }
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
      isLoading.value = false;
    } catch (e) {}
  }

  Future<bool> signUp() async {
    bool isSuccess =
        await AuthService().signUp(email: emailController.text.trim(), password: pwdController.text.trim(), name: nameController.text.trim()).load();
    return isSuccess;
  }
}
