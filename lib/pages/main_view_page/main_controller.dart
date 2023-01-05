import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/common/http_model/GetUserResponse.dart';
import 'package:kuhaejwo_app/common/service/http_service_manager.dart';

class MainController extends GetxController {
  TextEditingController searchTextEditingController = TextEditingController();
  HttpServiceManager httpServiceManager = HttpServiceManager();

  RxList<MateOfferResponse> mateOfferList = <MateOfferResponse>[].obs;

  @override
  void onReady() {
    fetchData();
  }

  fetchData() async {
    var res = await HttpServiceManager().getMateOfferListResponse().load();
    if (res.result) {
      mateOfferList.value = res.value?.data ?? [];
    } else {
      Common.showSnackbar(message: "리스트 불러오기 실패");
    }
  }
}
