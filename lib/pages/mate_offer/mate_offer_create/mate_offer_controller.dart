import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/http_model/GetUserResponse.dart';
import 'package:pet_app/common/service/auth_service.dart';

class MateOfferController extends GetxController {
  TextEditingController searchTextEditingController = TextEditingController();

  late MateOfferResponse mateOffer;
  AuthService authService = AuthService();
  @override
  onReady() {
    super.onReady();
    fetchData();
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

  fetchData() async {
    bool res = await authService.getMyMateOffer().load();
    if (res && authService.userPrefer.value != null) {
      //수정
    }
    // else {
    //   // 신규작성
    // }
  }
}
