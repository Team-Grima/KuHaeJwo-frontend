import 'package:get/get.dart';

class ChatRoomListController extends GetxController {
  final bool _error = false;
  @override
  void onReady() {
    super.onReady();
    refresh();
  }
}
