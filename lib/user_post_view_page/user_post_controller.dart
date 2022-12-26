import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/http_model/GetMateOfferListResponse.dart';
import 'package:pet_app/common/service/http_service_manager.dart';
import 'package:pet_app/route/routes.dart';

class UserPostController extends GetxController {
  TextEditingController searchTextEditingController = TextEditingController();
  HttpServiceManager httpServiceManager = HttpServiceManager();
  late UserDetailData userDetailData;
  @override
  void onInit() {
    userDetailData = (Get.arguments as UserDetailDataRouteParams).userDetailData;
    super.onInit();
  }
}
