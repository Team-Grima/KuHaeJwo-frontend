import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/common/utils/common_storage.dart';
import 'package:kuhaejwo_app/common/service/auth_service.dart';
import 'package:kuhaejwo_app/common/utils/service_response.dart';
import 'package:kuhaejwo_app/pages/home/home_view_page.dart';

class SignInController extends GetxController {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  bool isLoading = false;

  var isIdSave = false.obs;
  var isAutoLogin = true.obs;
  bool isAndroid = false;

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
    restoreId();
  }

  @override
  void onClose() {
    idController.dispose();
    pwdController.dispose();
    super.onClose();
  }

  void submit() async {
    // Get.offAllNamed(HomeViewPage.url);
    try {
      if (idController.text.isEmpty || pwdController.text.isEmpty) {
        isLoading = false;
        return;
      }

      var email = idController.text.trim();
      var pwd = pwdController.text.trim();
      ServiceResponse res = await AuthService().login(email, pwd).load();
      writeUserSettings();
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

  restoreId() {
    //restore id string
    if (CommonStorageKey.isIdSave.read.result && CommonStorageKey.isIdSave.read.value == true && CommonStorageKey.savedId.read.result) {
      isIdSave.value = true;
      idController.text = CommonStorageKey.savedId.read.value;
    }

    //restore autologin settings
    if (CommonStorageKey.isAutoLogin.read.result && CommonStorageKey.isAutoLogin.read.value == true) {
      isAutoLogin.value = true;
    }
  }

  writeUserSettings() {
    if (isIdSave.value) {
      CommonStorageKey.isIdSave.write(true);
      CommonStorageKey.savedId.write(idController.text.trim());
    } else {
      CommonStorageKey.isIdSave.write(false);
      CommonStorageKey.savedId.write(idController.text.trim());
    }
    if (isAutoLogin.value) {
      CommonStorageKey.isAutoLogin.write(true);
    } else {
      CommonStorageKey.isAutoLogin.write(null);
    }
  }
  // Future naverSubmit() async {
  //   if (isLoading) {
  //     return false;
  //   }

  //   isLoading = true;
  //   // var loginResult = await AuthService().signInWithNaver();

  //   if (loginResult.result) {
  //     var user = loginResult.value;

  //     //가입되지 않은 유저
  //     if (user != null && user.isUsUser == 0) {
  //       isLoading = false;
  //       // var navigation = await _navigationService.navigateTo(Routes.snsSignUpViewRoute);
  //       Get.toNamed('sns-signup');
  //     } else {
  //       // if (_isDetailRoute == true) {
  //       //   _navigationService.back();
  //       // } else if (_isMealViewLoginRoute == true) {
  //       //   await navigateToHomeRoute(isMealViewLoginRoute: true);
  //       // } else {
  //       //   await navigateToHomeRoute(isMealViewLoginRoute: false);
  //       // }
  //     }
  //   }

  //   isLoading = false;
  // }
}
