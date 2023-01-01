import 'dart:io';

import 'package:get/get.dart';

class CertificateAuthController extends GetxController {
  bool isLoading = false;

  bool isAndroid = false;

  @override
  void onInit() {
    super.onInit();
    isAndroid = Platform.isAndroid;
  }

  void fileUpload() async {}
}
