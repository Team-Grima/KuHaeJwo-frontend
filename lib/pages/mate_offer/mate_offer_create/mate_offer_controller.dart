import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/http_model/GetUserResponse.dart';
import 'package:pet_app/common/service/auth_service.dart';

class MateOfferController extends SuperController {
  TextEditingController searchTextEditingController = TextEditingController();

  late MateOfferResponse mateOffer;
  AuthService authService = AuthService();
  @override
  onReady() {
    super.onReady();
    fetchData();
  }

  RxList<String> selectedPrefer = <String>[].obs;

  addSelectedPrefer(String item) {
    selectedPrefer.add(item);
  }

  fetchData() async {
    bool res = await authService.getMyMateOffer().load();
    if (res && authService.myMateOffer.value != null) {
      for (String s in authService.userPrefer.value?.preferList ?? []) {
        addSelectedPrefer(s);
      }

      //수정
    }
    // else {
    //   // 신규작성
    // }
  }

  getSelectedPrefer() async {
    await fetchData();
    return selectedPrefer;
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    fetchData().load();
  }

  // submit() async {
  //   if (isPass.value) {
  //     var res = await .load();
  //     if (res) {
  //       Get.back();
  //     } else {
  //       Common.showSnackbar(message: "오류가 발생했습니다");
  //     }
  //     Get.back();
  //   }
  //   // if(selectedPrefer)
  // }
}
