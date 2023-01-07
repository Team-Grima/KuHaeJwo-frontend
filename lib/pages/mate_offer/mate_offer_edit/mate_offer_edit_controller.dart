import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/service/auth_service.dart';
import 'package:kuhaejwo_app/pages/mate_offer/mate_offer_create/mate_offer_view_page.dart';

class MateOfferEditController extends GetxController {
  AuthService authService = AuthService();
  TextEditingController headerEditingController = TextEditingController();
  TextEditingController bodyEditingController = TextEditingController();
  late String bodyString;
  RxList<bool> visibleList = <bool>[].obs;
  List<String> detailStringList = [];
  @override
  void onInit() {
    super.onInit();
    bodyUserDetail();
    generateUserDetailString();
    detailStringList.addAll(MateOfferViewPage.generateDetailString(authService.userInfoDetail.value!).split("\n").map((e) {
      return e.replaceAll("✅", "");
    }).toList());
    visibleList.value = List.generate(detailStringList.length, (index) => true);
  }

  generateUserDetailString() {}

  toggleUserDetailInfo(int index) {
    visibleList[index] = !visibleList[index];
  }

  bodyUserDetail() {
    String res = "";
    if (res != "") {
      res = "🙋🏻‍♀️ 저는요 !\n\n$res";
    }
    headerEditingController.text = authService.myMateOffer.value?.title ?? "";
    bodyEditingController.text = res;

    bodyString = res;
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

  updateUserPost() async {
    var title = headerEditingController.text;
    var body = bodyEditingController.text.split("하고 싶은 말")[1].replaceFirst("\n", "").replaceFirst("\n", "");
    //고쳐주세요... textfield에서 body부분(하고싶은말)만 가져올 방법을 모르겠습니다;;

    Map data = {
      "title": title,
      "dormitoryName": "lake",
      "body": body,
      "matching": true,
      "goodnessOfFit": 50,
    };

    bool? res = await AuthService().updateMateOffer(data, true);
    if (res) {
      Get.offNamedUntil("/home", ((route) => Get.currentRoute == "/mainView"));
    } else {
      // TODO::게시물 수정 실패
    }
  }
}
