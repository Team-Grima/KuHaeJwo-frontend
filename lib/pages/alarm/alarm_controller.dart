import 'package:get/get.dart';

class AlarmController extends GetxController {
  RxList<Noti> notifications = <Noti>[].obs;
  @override
  void onInit() {
    notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020"));
    notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020"));
    notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020"));
    notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020"));
    notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020"));
    notifications.add(Noti(title: "asdfasdfasdfasfasdfasd", body: "bodybody", receivedDate: "20002020"));
    super.onInit();
  }
}

class Noti {
  String? title;
  String? body;
  String? receivedDate;

  Noti({this.title, this.body, this.receivedDate});
}
