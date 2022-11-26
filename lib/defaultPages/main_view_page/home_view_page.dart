import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/defaultPages/main_view_page/main_view_page.dart';
import 'package:pet_app/home/home_controller.dart';

class HomeViewPage extends StatelessWidget {
  const HomeViewPage({Key? key}) : super(key: key);
  static const url = '/home';
  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = [
      const MainPage(),
      const MainPage(),
      const MainPage(),
      const MainPage(),
      const MainPage(),

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
              onTap: (value) => controller.selectedIndex,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/bottom_navi_home.svg"),
                  activeIcon: SvgPicture.asset("assets/icons/bottom_navi_home.svg"),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/bottom_navi_chat.svg"),
                  activeIcon: SvgPicture.asset("assets/icons/bottom_navi_chat.svg"),
                  label: "",
                ),
                // BottomNavigationBarItem(
                //   icon: SvgPicture.asset("assets/icons/bottom_navi_settings.svg"),
                //   activeIcon: SvgPicture.asset("assets/icons/bottom_navi_home.svg"),
                //   label: "",
                // ),
                // BottomNavigationBarItem(
                //   icon: SvgPicture.asset("assets/icons/bottom_navi_home.svg"),
                //   activeIcon: SvgPicture.asset("assets/icons/bottom_navi_home.svg"),
                //   label: "",
                // ),
                // BottomNavigationBarItem(
                //   icon: SvgPicture.asset("assets/icons/bottom_navi_home.svg"),
                //   activeIcon: SvgPicture.asset("assets/icons/bottom_navi_home.svg"),
                //   label: "",
                // ),
              ],
            ),
          )),
    );
  }
}
