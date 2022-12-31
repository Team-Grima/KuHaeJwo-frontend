import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/service/auth_service.dart';

class ChatRoomListController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    AuthService().chatLogin().load();
    refresh();
  }
}
