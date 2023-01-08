import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/service/auth_service.dart';
import 'package:kuhaejwo_app/pages/mate_offer/mate_offer_create/mate_offer_view_page.dart';

class MateOfferEditController extends GetxController {
  AuthService authService = AuthService();
  TextEditingController headerEditingController = TextEditingController();
  TextEditingController bodyEditingController = TextEditingController();
  RxList<bool> visibleList = <bool>[].obs;
  List<String> detailStringList = [];
  @override
  void onInit() {
    super.onInit();
    fetchData();
    detailStringList.addAll(MateOfferViewPage.generateDetailString(authService.userInfoDetail.value!).split("\n").map((e) {
      return e.replaceAll("✅", "");
    }).toList());
    visibleList.value = List.generate(detailStringList.length, (index) => true);
  }

  fetchData() async {
    // Get.find<MateOfferController>().fetchMateOfferData().load();
  }

  toggleUserDetailInfo(int index) {
    visibleList[index] = !visibleList[index];
  }

  getHeader() {
    String res = "";
    if (authService.myMateOffer.value != null) {
      res = authService.myMateOffer.value?.title ?? "";
    }
    headerEditingController.text = res;
    return res;
  }

  getBody() {
    String res = "";
    if (authService.myMateOffer.value != null) {
      res = authService.myMateOffer.value?.body ?? "";
    }
    bodyEditingController.text = res;
    return res;
  }

  updateUserPost() async {
    var title = headerEditingController.text;
    var body = bodyEditingController.text;
    //고쳐주세요... textfield에서 body부분(하고싶은말)만 가져올 방법을 모르겠습니다;;

    Map data = {
      "title": title,
      // "dormitoryName": "lake",
      "body": body,
      // "matching": true,
      // "goodnessOfFit": 50,
    };

    bool? res = await AuthService().updateMateOffer(data, true);
    if (res) {
      Get.offNamedUntil("/home", ((route) => Get.currentRoute == "/mainView"));
    } else {
      // TODO::게시물 수정 실패
    }
  }
}
