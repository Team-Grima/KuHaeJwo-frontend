import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/common/http_model/GetUserResponse.dart';
import 'package:kuhaejwo_app/common/service/auth_service.dart';
import 'package:kuhaejwo_app/common/service/http_service_manager.dart';
import 'package:kuhaejwo_app/common/service/socket_service.dart';
import 'package:kuhaejwo_app/pages/chat/chat_room/chat_room_view_page.dart';

class MainController extends GetxController {
  TextEditingController searchTextEditingController = TextEditingController();
  HttpServiceManager httpServiceManager = HttpServiceManager();
  AuthService authService = AuthService();

  RxList<MateOfferResponse> mateOfferList = <MateOfferResponse>[].obs;

  @override
  void onReady() {
    fetchData();
  }

  createChatRoom(MateOfferResponse mateOffer) {
    int receiverId = mateOffer.userProfile?.userId ?? -1;
    if (receiverId != -1) {
      SocketService().request("createChatRoom", {"receiver": receiverId});
      Get.toNamed(ChatRoomViewPage.url, arguments: mateOffer.userProfile!);
    }
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
