import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kuhaejwo_app/common/http_model/NotificationResponse.dart';
import 'package:kuhaejwo_app/pages/alarm/alarm_controller.dart';
import 'package:kuhaejwo_app/common/common.dart';

import 'package:get/get.dart';

class AlarmViewPage extends StatelessWidget {
  const AlarmViewPage({Key? key}) : super(key: key);
  static const url = '/alarm';

  @override
  Widget build(BuildContext context) {
    AlarmController controller = Get.put(AlarmController());
    return Scaffold(
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
              child: Obx(
                () => Column(
                  children: [
                    ...List.generate(controller.notifications.length, (index) => _alarmFragment(controller.notifications[index], controller)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _alarmFragment(NotificationResponse notification, AlarmController controller) {
    return InkWell(
      onTap: () {
        controller.clickNotification(notification.id, "mate");
      },
      child: Container(
        decoration: BoxDecoration(color: notification.isRead ?? false ? CommonColor.white : CommonColor.gray01),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 24.r),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/alarm_lined.png",
                    width: 24.r,
                    height: 24.r,
                  ),
                  SizedBox(width: 10.r),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title ?? '',
                        style: CommonTextStyle(color: CommonColor.black, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        notification.createdAt ?? '',
                        style: CommonTextStyle(color: CommonColor.gray03, fontSize: 11, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 1.r)
          ],
        ),
      ),
    );
  }
}
