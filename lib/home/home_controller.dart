import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  changePageIndex(int value) {
    currentIndex.value = value;
  }
}
