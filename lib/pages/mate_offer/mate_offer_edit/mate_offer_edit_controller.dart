import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/service/auth_service.dart';
import 'package:pet_app/pages/mate_offer/mate_offer_create/mate_offer_view_page.dart';

class MateOfferEditController extends GetxController {
  AuthService authService = AuthService();
  TextEditingController headerEditingController = TextEditingController();
  TextEditingController bodyEditingController = TextEditingController();
  getBodyString() {
    return bodyUserDetail();
  }

  bodyUserDetail() {
    String res = "";

    res = MateOfferViewPage.generateDetailString(authService.userInfoDetail.value!) + "\n\n" + bodyUserPrefer() + "\n\n" + bodyBody();
    if (res != "") {
      res = "🙋🏻‍♀️ 저는요 !\n\n$res";
    }
    bodyEditingController.text = res;

    return res;
  }

  bodyUserPrefer() {
    String res = "";
    for (String i in authService.userPrefer.value!.preferList ?? []) {
      res += "#$i\n";
    }

    if (res != "") {
      res = "👭🏻 이런 룸메를 원해요!\n\n$res";
    }
    bodyEditingController.text = res;

    return res;
  }

  bodyBody() {
    String res = "";
    if (authService.myMateOffer.value != null) {
      res = authService.myMateOffer.value?.body ?? "";
    }

    res = "👭🏻 하고 싶은 말\n\n$res";

    bodyEditingController.text = res;

    return res;
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
