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
      // 올바른 비밀번호 백엔드 받은거 검증 로직 필요
      currentPasswordWarninng.value = '올바른 비밀번호를 입력하세요';
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
      newPasswordWarninng.value = '8자리 이상 입력하세요';
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
      checkNewPasswordWarninng.value = '입력한 비밀번호와 달라요';
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
    isAllPassing = currentPassword.text != '' && checkNewPassword.text != '' && newPassword.text != ''; //여러 조건 추가 모두 pass 일 때 true 로 변경
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
  //       _returnMessage = "비밀번호가 다릅니다.";
  //       // notifyListeners();
  //       setLoadingStatus(false);

  //       return;
  //     }

  //     if (_checkNewPassword.text.isEmpty || _newPassword.text.isEmpty) {
  //       _returnMessage = "비밀번호를 입력해주세요.";
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

  //       //여기가 성공을 해도 singIn.result에서 true로 안가고 false로 감
  //       if (signIn.result) {
  //         _logger.d("Change password succeeded");
  //         // _navigationService.back();
  //         Get.back();
  //       } else {
  //         setLoadingStatus(false);
  //         Common.commonModal(
  //           mainText: '비밀번호 변경 실패',
  //           subText: checkChangePassword.errorMsg,
  //         );

  //         //  await _dialogService.showCustomDialog(
  //         //  variant: DialogType.yes, description: "비밀번호 변경 실패\n${checkChangePassword.errorMsg ?? ""}", mainButtonTitle: "확인");
  //       }
  //       // notifyListeners();
  //     } else {
  //       Common.commonModal(
  //         mainText: '비밀번호 변경 실패',
  //         subText: checkChangePassword.errorMsg,
  //       );
  //       // await _dialogService.showCustomDialog(variant: DialogType.yes, description: "비밀번호 변경 실패\n${checkChangePassword.errorMsg ?? ""}", mainButtonTitle: "확인");
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
