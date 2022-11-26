import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;
  chanteSelectedIndex(int value) {
    selectedIndex.value = value;
  }
}
