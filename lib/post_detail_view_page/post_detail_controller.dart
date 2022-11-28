import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/service/http_service_manager.dart';
import 'package:pet_app/main_view_page/main_view_page.dart';
import 'package:pet_app/route/routes.dart';

class PostDetailController extends GetxController {
  TextEditingController searchTextEditingController = TextEditingController();
  HttpServiceManager httpServiceManager = HttpServiceManager();
  late Post post;
  @override
  void onInit() {
    post = (Get.arguments as PostDetailRouteParams).post;
    super.onInit();
  }
}
