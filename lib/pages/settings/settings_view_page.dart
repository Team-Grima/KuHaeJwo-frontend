import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_app/pages/auth/login/sign_in_view_page.dart';
import 'package:pet_app/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/service/auth_service.dart';

class SettingsViewPage extends StatelessWidget {
  const SettingsViewPage({Key? key}) : super(key: key);
  static const url = '/more-settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        backgroundColor: Colors.white,
        title: '설정',
        iconColor: Colors.black,
        context: context,
      ),
      backgroundColor: CommonColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.r),
            Divider(height: 1.r),
            listButton(title: "알림설정", route: "/alert-settings"),
            Divider(height: 1.r),
            AuthService().authed ? listButton(title: "로그인", route: "log-in", topPadding: 2.r) : listButton(title: "로그아웃", route: "log-out", topPadding: 2.r),
            !AuthService().authed ? Divider(height: 1.r) : Container(),
            !AuthService().authed ? listButton(title: "회원탈퇴", route: "/subscription", topPadding: 2.r) : Container(),
          ],
        ),
      ),
    );
  }
}

Widget listButton({required String title, required String route, double? topPadding}) {
  return Container(
    margin: EdgeInsets.only(top: topPadding ?? 0),
    color: CommonColor.white,
    child: InkWell(
      onTap: () async {
        if (route == "log-out") {
          if (await Get.dialog(Common.commonModal(
                mainText: "로그아웃",
                subText: "로그아웃 하시겠습니까?",
                button1Text: "아니오",
                button2Text: "예",
                button2Function: null,
                numberOfButton: 2,
                button2Color: CommonColor.disabledGrey,
                button2TextColor: CommonColor.black,
              )) ??
              false) {
            AuthService().logout();
          }
        } else if (route == "log-in") {
          Get.offAllNamed(SignInViewPage.url);
        } else {
          Get.toNamed(route);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 18.r, vertical: 16.5.r),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: CommonTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: CommonColor.black,
                    )),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SvgPicture.asset("assets/icons/right_arrow.svg")],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget exitButton() {
  return Container(
    margin: EdgeInsets.only(top: 5.r),
    color: CommonColor.white,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 18.r, vertical: 10.r),
      child: Row(
        children: [
          const Spacer(),
          InkWell(
            onTap: () {
              // AuthService().logout_permenently();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('탈퇴하기',
                    style: CommonTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
                      color: CommonColor.gray02,
                    )),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
