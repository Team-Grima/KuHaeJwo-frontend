import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/http_model/GetUserResponse.dart';
import 'package:pet_app/common/service/auth_service.dart';

class MateOfferEditController extends GetxController {
  TextEditingController searchTextEditingController = TextEditingController();

  late MateOfferResponse mateOffer;
  AuthService authService = AuthService();

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
