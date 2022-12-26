import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_app/home/home_view_page.dart';

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
    isAndroid = Platform.isAndroid;
    super.onInit();
  }

  @override
  void onClose() {
    idController.dispose();
    pwdController.dispose();
    super.onClose();
  }

  void submit() async {
    Get.offAllNamed(HomeViewPage.url);
    try {
      if (isLoading) {
        return;
      }

      isLoading = true;

      if (idController.text.isEmpty || pwdController.text.isEmpty) {
        isLoading = false;
        return;
      }

      var email = idController.text.trim();
      var pwd = pwdController.text.trim();

      // var res = await AuthService().signInWithEmail(email, pwd, null, isAutoLogin.value);

      // isLoading = false;
      // if (res.result) {
      //   // _setLog.trackingUser("signin_view", "로그인", "", "");
      //   // if (_isDetailRoute == true) {
      //   // await _mealService.initialize();
      //   Get.offAllNamed('/home');
      //   // } else if (_isMealViewLoginRoute == true) {
      //   //   await navigateToHomeRoute(isMealViewLoginRoute: true);
      //   // } else {
      //   //   print("here");
      //   //   await navigateToHomeRoute(isMealViewLoginRoute: false);
      //   // }
      // } else {
      //   Common.showSnackbar(message: res.errorMsg);

      //   Get.dialog(
      //     Common.commonModal(
      //       mainText: '로그인 오류',
      //       subText: '올바른 아이디(이메일) 또는 비밀번호를 입력하세요.',
      //       button1Color: CommonColor.mainMidGreen,
      //       button1TextColor: CommonColor.white,
      //       button1Text: '확인',
      //       numberOfButton: 1,
      //     ),
      //   );
      //   // await Get.defaultDialog(title: "로그인 실패", middleText: res.errorMsg);
      // }
    } catch (e) {
      // _setLog.setCrashLog(Routes.signInViewRoute, "submit", e.toString());
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
