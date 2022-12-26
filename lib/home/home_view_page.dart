import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:pet_app/auth/password_change/change_password_view_page.dart';
import 'package:pet_app/chat/chat_room_list/chat_room_list_view_page.dart';
import 'package:pet_app/common/common.dart';

import 'package:pet_app/main_view_page/main_view_page.dart';
import 'package:pet_app/home/home_controller.dart';
import 'package:pet_app/my_page/mypage_view_page.dart';

class HomeViewPage extends StatelessWidget {
  const HomeViewPage({Key? key}) : super(key: key);
  static const url = '/home';
  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = [
      const MainPage(),
      const ChatRoomListViewPage(),
      const MainPage(),
      const MyPageViewPage(),
      const ChangePWViewPage(),
      // const ChatPage(),
      // const AddPostPage(),
      // const MyPageViewPage(),
      // const SettingViewPage(),
    ];

    var controller = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
          body: Obx(
            () => IndexedStack(
              index: controller.selectedIndex.value,
              children: pageList,
            ),
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              backgroundColor: CommonColor.gray01,
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.selectedIndex.value,
              showSelectedLabels: true,
              selectedItemColor: CommonColor.gray02,
              onTap: (value) => controller.selectedIndex.value = value,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/bottom_main.svg", color: CommonColor.gray03),
                  activeIcon: SvgPicture.asset("assets/icons/bottom_main.svg", color: CommonColor.mainDarkGreen),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/bottom_chat.svg", color: CommonColor.gray03),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/bottom_chat.svg",
                    color: CommonColor.mainDarkGreen,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/bottom_add.svg", color: CommonColor.gray03),
                  activeIcon: SvgPicture.asset("assets/icons/bottom_add.svg"),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/bottom_3dot.svg",
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/bottom_3dot.svg",
                    color: CommonColor.mainDarkGreen,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/bottom_main.svg", color: CommonColor.disabledGrey),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/bottom_main.svg",
                    color: CommonColor.mainDarkGreen,
                  ),
                  label: "",
                ),
              ],
            ),
          )),
    );
  }
}
