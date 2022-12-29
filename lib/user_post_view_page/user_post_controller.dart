import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/http_model/GetUserResponse.dart';
import 'package:pet_app/common/service/http_service_manager.dart';
import 'package:pet_app/route/routes.dart';

class UserPostController extends GetxController {
  TextEditingController searchTextEditingController = TextEditingController();
  HttpServiceManager httpServiceManager = HttpServiceManager();
  late MateOfferResponse mateOffer;
  @override
  void onInit() {
    mateOffer = (Get.arguments as MateOfferUserParams).mateOffer;
    super.onInit();
  }
}
