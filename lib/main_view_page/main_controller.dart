import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/http_model/GetUserResponse.dart';
import 'package:pet_app/common/service/http_service_manager.dart';
import 'package:pet_app/main_view_page/main_view_page.dart';

class MainController extends GetxController {
  TextEditingController searchTextEditingController = TextEditingController();
  HttpServiceManager httpServiceManager = HttpServiceManager();
  RxList<Post> posts = <Post>[].obs;
  RxList<MateOfferResponse> mateOfferList = <MateOfferResponse>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    var res = await HttpServiceManager().getMateOfferListResponse();
    if (res.result) {
      mateOfferList.value = res.value?.data ?? [];
    } else {
      Common.showSnackbar(message: "리스트 불러오기 실패");
    }
  }
}
