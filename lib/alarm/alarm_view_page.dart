import 'package:flutter/material.dart';
import 'package:pet_app/alarm/alarm_controller.dart';
import 'package:pet_app/common/common.dart';

import 'package:get/get.dart';

class AlarmViewPage extends StatelessWidget {
  const AlarmViewPage({Key? key}) : super(key: key);
  static const url = '/alarm';

  @override
  Widget build(BuildContext context) {
    AlarmController controller = Get.put(AlarmController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColor.white,
        appBar: CommonAppBar(
          context: context,
          title: "알림",
          hasGetBack: false,
          onTapFunction: Get.back,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: IntrinsicHeight(
                  child: Column(
                children: [
                  ...List.generate(controller.notifications.length, (index) => _alarmFragment(controller.notifications[index])),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }

  _alarmFragment(Noti notification) {
    return Text(notification.title ?? '');
  }
}
