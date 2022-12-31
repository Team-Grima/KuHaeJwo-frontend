import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:pet_app/pages/chat/chat_room_list/chat_room_list_view_page.dart';
import 'package:pet_app/common/common.dart';

import 'package:pet_app/pages/main_view_page/main_view_page.dart';
import 'package:pet_app/pages/home/home_controller.dart';
import 'package:pet_app/pages/mate_offer/mate_offer_create/mate_offer_view_page.dart';
import 'package:pet_app/pages/my_page/mypage_view_page.dart';
import 'package:pet_app/pages/settings/settings_view_page.dart';

class HomeViewPage extends StatelessWidget {
  const HomeViewPage({Key? key}) : super(key: key);
  static const url = '/home';
  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = [
      const MainPage(),
      const ChatRoomListViewPage(),
      const MateOfferViewPage(),
      const MyPageViewPage(),
      const SettingsViewPage(),
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
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: CommonColor.gray02,
              onTap: (value) => controller.selectedIndex.value = value,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: CommonColor.gray03,
                    size: 30,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: CommonColor.mainDarkGreen,
                    size: 30,
                  ),
                  // icon: SvgPicture.asset("assets/icons/bottom_main.svg",
                  //     color: CommonColor.gray03),
                  // activeIcon: SvgPicture.asset("assets/icons/bottom_main.svg",
                  //     color: CommonColor.mainDarkGreen),
                  label: "",
                ),
                BottomNavigationBarItem(
                  // icon: Icon(
                  //   Icons.chat,
                  //   size: 30,
                  //   color: CommonColor.gray03,
                  // ),
                  // activeIcon: Icon(
                  //   Icons.chat,
                  //   size: 30,
                  //   color: CommonColor.mainDarkGreen,
                  // ),
                  icon: SvgPicture.asset("assets/icons/bottom_chat.svg", color: CommonColor.gray03),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/bottom_chat.svg",
                    color: CommonColor.mainDarkGreen,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/bottom_add.svg", color: CommonColor.gray03),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/bottom_add.svg",
                    color: CommonColor.mainDarkGreen,
                  ),
                  label: "",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.more_horiz,
                    color: CommonColor.gray03,
                    size: 30,
                  ),
                  activeIcon: Icon(
                    Icons.more_horiz_outlined,
                    color: CommonColor.mainDarkGreen,
                    size: 30,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    color: CommonColor.gray03,
                    size: 25.r,
                  ),
                  activeIcon: Icon(
                    Icons.settings,
                    color: CommonColor.mainDarkGreen,
                    size: 25.r,
                  ),
                  // icon: SvgPicture.asset("assets/icons/bottom_main.svg",
                  //     color: CommonColor.disabledGrey),
                  // activeIcon: SvgPicture.asset(
                  //   "assets/icons/bottom_main.svg",
                  //   color: CommonColor.mainDarkGreen,
                  // ),
                  label: "",
                ),
              ],
            ),
          )),
    );
  }
}
