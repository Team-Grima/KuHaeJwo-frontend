import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/home/home_controller.dart';

class HomeViewPage extends StatelessWidget {
  const HomeViewPage({Key? key}) : super(key: key);
  static const url = '/home';
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
        body: Obx(() {
          switch (controller.currentIndex.value) {
            case 0:
              return Container();
            // case RouteName.album:
            //   return Album();
            // case RouteName.letter:
            //   return Letter();
            // case RouteName.profile:
            //   return Profile();
          }

          return Container();
        }),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: CommonColor.gray01,
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentIndex.value,
            showSelectedLabels: true,
            selectedItemColor: CommonColor.gray02,
            onTap: (value) => controller.changePageIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: CommonColor.gray02,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: CommonColor.gray03,
                  ),
                  label: "홈"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.photo,
                    color: CommonColor.gray02,
                  ),
                  activeIcon: Icon(
                    Icons.photo,
                    color: CommonColor.gray02,
                  ),
                  label: "앨범"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.mail_outline,
                    color: CommonColor.gray02,
                  ),
                  activeIcon: Icon(
                    Icons.mail_outline,
                    color: CommonColor.gray02,
                  ),
                  label: "편지"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: CommonColor.gray02,
                  ),
                  activeIcon: Icon(
                    Icons.person,
                    color: CommonColor.gray02,
                  ),
                  label: "내 프로필"),
            ],
          ),
        ));
  }
}
