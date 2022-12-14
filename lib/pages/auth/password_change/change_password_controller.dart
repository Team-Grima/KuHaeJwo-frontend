import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:logger/logger.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/common/service/auth_service.dart';

class ChangePasswordController extends GetxController {
  final AuthService _authService = AuthService();
  final Logger _logger = Common.logger;

  final TextEditingController _currentPassword = TextEditingController();

  TextEditingController get currentPassword => _currentPassword;

  final TextEditingController _newPassword = TextEditingController();

  TextEditingController get newPassword => _newPassword;

  final TextEditingController _checkNewPassword = TextEditingController();

  TextEditingController get checkNewPassword => _checkNewPassword;

  final String _returnMessage = "";

  final currentPasswordWarninng = ''.obs;

  final currentPasswordValid = true.obs;

  final newPasswordWarninng = ''.obs;

  final newPasswordValid = true.obs;

  final checkNewPasswordWarninng = ''.obs;

  final checkNewPasswordValid = true.obs;

  String get returnMessage => _returnMessage;

  RxBool _isLoading = false.obs;

  RxBool get isLoading => _isLoading;
  bool isAllPassing = false;

  Map<TextEditingController, RxBool> isDeleteButtonVisibleMap = <TextEditingController, RxBool>{};

  @override
  void onInit() {
    currentPassword.addListener(currentPasswardListener);
    newPassword.addListener(newPasswardListener);
    checkNewPassword.addListener(newPasswardCheckListener);
    _isLoading = false.obs;
    final textEditingControllerList = [
      currentPassword,
      newPassword,
      checkNewPassword,
    ];
    for (var i in textEditingControllerList) {
      isDeleteButtonVisibleMap[i] = false.obs;

      i.addListener(() {
        isDeleteButtonVisibleMap[i]!.value = i.text.isNotEmpty;
      });
    }
    super.onInit();
  }

  @override
  void dispose() {
    currentPassword.dispose();
    newPassword.dispose();
    checkNewPassword.dispose();
  }

  void currentPasswardListener() {
    if (currentPassword.text.length < 9) {
      // ????????? ???????????? ????????? ????????? ?????? ?????? ??????
      currentPasswordWarninng.value = '????????? ??????????????? ???????????????';
      currentPasswordValid.value = false;
    } else {
      currentPasswordWarninng.value = '';
      currentPasswordValid.value = true;
    }
    verify();
    update();
  }

  void newPasswardListener() {
    if (newPassword.text.length < 8) {
      newPasswordWarninng.value = '8?????? ?????? ???????????????';
      newPasswordValid.value = false;
    } else {
      newPasswordWarninng.value = '';
      newPasswordValid.value = true;
    }
    verify();
    update();
  }

  void newPasswardCheckListener() {
    if (newPassword.text.trim() != checkNewPassword.text.trim() || checkNewPassword.text == '') {
      checkNewPasswordWarninng.value = '????????? ??????????????? ?????????';
      checkNewPasswordValid.value = false;
    } else {
      checkNewPasswordWarninng.value = '';
      checkNewPasswordValid.value = true;
    }
    verify();
    update();
  }

  void setLoadingStatus(bool value) {
    _isLoading.value = value;
    // notifyListeners();
  }

  bool verify() {
    isAllPassing = currentPassword.text != '' && checkNewPassword.text != '' && newPassword.text != ''; //?????? ?????? ?????? ?????? pass ??? ??? true ??? ??????
    return false;
  }

  // Future submit() async {
  //   currentPasswardListener();
  //   newPasswardListener();
  //   newPasswardCheckListener();
  //   try {
  //     if (_isLoading.value) {
  //       return;
  //     }
  //     setLoadingStatus(true);

  //     if (_checkNewPassword.text.trim() != _newPassword.text.trim()) {
  //       _returnMessage = "??????????????? ????????????.";
  //       // notifyListeners();
  //       setLoadingStatus(false);

  //       return;
  //     }

  //     if (_checkNewPassword.text.isEmpty || _newPassword.text.isEmpty) {
  //       _returnMessage = "??????????????? ??????????????????.";
  //       // notifyListeners();
  //       setLoadingStatus(false);
  //       return;
  //     }

  //     var checkChangePassword = await _authService.changePassword(_currentPassword.text.trim(), _newPassword.text.trim());

  //     if (checkChangePassword.result) {
  //       var prefs = await SharedPreferences.getInstance();
  //       var email = _authService.user!.email;
  //       var autoSignin = prefs.getBool('auto_signin') ?? false;
  //       var signIn = await _authService.signInWithEmail(email!, _newPassword.text.trim(), null, autoSignin);

  //       //????????? ????????? ?????? singIn.result?????? true??? ????????? false??? ???
  //       if (signIn.result) {
  //         _logger.d("Change password succeeded");
  //         // _navigationService.back();
  //         Get.back();
  //       } else {
  //         setLoadingStatus(false);
  //         Common.commonModal(
  //           mainText: '???????????? ?????? ??????',
  //           subText: checkChangePassword.errorMsg,
  //         );

  //         //  await _dialogService.showCustomDialog(
  //         //  variant: DialogType.yes, description: "???????????? ?????? ??????\n${checkChangePassword.errorMsg ?? ""}", mainButtonTitle: "??????");
  //       }
  //       // notifyListeners();
  //     } else {
  //       Common.commonModal(
  //         mainText: '???????????? ?????? ??????',
  //         subText: checkChangePassword.errorMsg,
  //       );
  //       // await _dialogService.showCustomDialog(variant: DialogType.yes, description: "???????????? ?????? ??????\n${checkChangePassword.errorMsg ?? ""}", mainButtonTitle: "??????");
  //     }
  //     setLoadingStatus(false);
  //   } catch (e) {
  //     // _setLog.setCrashLog(Routes.signInViewRoute, "submit", e.toString());
  //   }
  // }

  void navigateToBack() {
    // _navigationService.back();
    Get.back();
  }
}
