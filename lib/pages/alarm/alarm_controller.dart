import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/common/http_model/NotificationResponse.dart';
import 'package:kuhaejwo_app/common/service/http_service_manager.dart';
import 'package:kuhaejwo_app/common/utils/service_response.dart';
import 'package:kuhaejwo_app/pages/home/home_controller.dart';

class AlarmController extends GetxController {
  RxList<NotificationResponse> notifications = <NotificationResponse>[].obs;
  @override
  onReady() {
    super.onReady();
    fetchData();
  }

  fetchData() async {
    ServiceResponse<List<NotificationResponse>> res = await HttpServiceManager().getNotificationResponse().load();
    if (res.result) {
      notifications.value = res.value ?? [];
    } else {
      Common.showSnackbar(message: "리스트 불러오기 실패");
    }
  }

  clickNotification(int? noticationId, String? notificationRoute) {
    if (noticationId == null || notificationRoute == null) {
      Get.back();
      Common.showSnackbar(message: "오류 발생 관리자에게 문의해주세요");
    } else {
      HttpServiceManager().getReadNotification(noticationId);
      Get.back();
      if (notificationRoute.contains("chat")) {
        Get.find<HomeController>().selectedIndex.value = 1;
        //TODO :: open chat page

      } else if (notificationRoute.contains("mate")) {
        Get.find<HomeController>().selectedIndex.value = 1;
        //TODO :: open mateoffer view page
      }
      // Get.until((route) => Get.currentRoute == '/home');
    }
  }
}
