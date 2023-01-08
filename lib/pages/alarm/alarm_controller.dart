import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/common/http_model/NotificationResponse.dart';
import 'package:kuhaejwo_app/common/service/http_service_manager.dart';
import 'package:kuhaejwo_app/common/utils/service_response.dart';

class AlarmController extends GetxController {
  RxList<NotificationResponse> notifications = <NotificationResponse>[].obs;
  @override
  // void onReady() {
  //   super.onReady();
  //   notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020", route: "/home", isRead: false));
  //   notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020", route: "/home", isRead: false));
  //   notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020", route: "/home", isRead: false));
  //   notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020", route: "/home", isRead: false));
  //   notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020", route: "/home", isRead: false));
  //   notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020", route: "/home", isRead: false));
  // }
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
}

// class Noti {
//   String title;
//   String body;
//   String receivedDate;
//   String route;
//   bool isRead;

//   Noti({required this.title, required this.body, required this.receivedDate, required this.route, required this.isRead});
// }
