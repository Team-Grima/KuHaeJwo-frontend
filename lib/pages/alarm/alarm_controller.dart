import 'package:get/get.dart';

class AlarmController extends GetxController {
  RxList<Noti> notifications = <Noti>[].obs;
  @override
  void onInit() {
    notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020", route: "/home", isRead: false));
    notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020", route: "/home", isRead: false));
    notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020", route: "/home", isRead: false));
    notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020", route: "/home", isRead: false));
    notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020", route: "/home", isRead: false));
    notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020", route: "/home", isRead: false));
    super.onInit();
  }
}

class Noti {
  String title;
  String body;
  String receivedDate;
  String route;
  bool isRead;

  Noti({required this.title, required this.body, required this.receivedDate, required this.route, required this.isRead});
}
