import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/auth/login/sign_in_controller.dart';
import 'package:pet_app/common/common.dart';

/*
기본 left, right padding값: 24.w
 */

class SignInViewPage extends StatelessWidget {
  const SignInViewPage({Key? key}) : super(key: key);
  static const String url = "/sign-in";

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.put(SignInController());
    return DefaultTextHeightBehavior(
      textHeightBehavior: const TextHeightBehavior(leadingDistribution: TextLeadingDistribution.even),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                // CommonAppBar(
                //   context: context,
                //   title: '로그인',
                //   shadowColor: Colors.transparent,
                //   leadingAssetPath: 'assets/icon/appbar_close.svg',
                // ),
                Padding(padding: EdgeInsets.only(top: 12.r), child: SvgPicture.asset('assets/images/logo.svg')),
                _divider(CommonColor.gray02, 24.r), //Top padding
                _infoMessage('쿠해줘\n시작하기', CommonTextStyle(fontSize: 30, color: CommonColor.gray05, fontWeight: FontWeight.w400), 30.r),
                _infoMessage('로그인', CommonTextStyle(fontSize: 20, color: CommonColor.gray05, fontWeight: FontWeight.w400), 90.r),
                _idInput('아이디(이메일)', controller, 20.r, 12.r), //bottom padding
                _passwordInput('비밀번호', controller, 12.r), //bottom padding
                _checkBoxLine(controller),
                _submitButton(controller, 24.r), //top padding
                _findBar()
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _infoMessage(String text, TextStyle style, double top) {
  return Padding(
    padding: EdgeInsets.fromLTRB(24.r, top, 0.0, 0.0),
    child: Row(children: [
      Text(
        text,
        style: style,
      ),
    ]),
  );
}

Widget _idInput(String hintText, SignInController controller, double top, double bottom) {
  return Padding(
    padding: EdgeInsets.fromLTRB(24.r, top, 24.r, bottom),
    child: TextField(
      textInputAction: TextInputAction.done,
      style: CommonTextStyle.b04(),
      keyboardType: TextInputType.emailAddress,
      controller: controller.idController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: CommonColor.gray02), borderRadius: BorderRadius.circular(5.r)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: CommonColor.mainMidGreen, width: 1.5.r), borderRadius: BorderRadius.circular(5.r)),
        contentPadding: EdgeInsets.symmetric(vertical: 15.5.r, horizontal: 24.r),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r)),
        hintText: hintText,
        hintStyle: CommonTextStyle.b03(color: CommonColor.gray03),
      ),
    ),
  );
}

Widget _passwordInput(String hintText, SignInController controller, double bottom) {
  return Padding(
    padding: EdgeInsets.fromLTRB(24.r, 0.0, 24.r, bottom),
    child: TextField(
      textInputAction: TextInputAction.done,
      style: CommonTextStyle.b04(),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      controller: controller.pwdController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: CommonColor.gray02), borderRadius: BorderRadius.circular(5.r)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: CommonColor.mainMidGreen, width: 1.5.r), borderRadius: BorderRadius.circular(5.r)),
        contentPadding: EdgeInsets.symmetric(vertical: 15.5.r, horizontal: 24.r),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r)),
        hintText: hintText,
        hintStyle: CommonTextStyle.b03(color: CommonColor.gray03),
      ),
    ),
  );
}

Widget _divider(Color color, double top) {
  return Padding(
    padding: EdgeInsets.fromLTRB(24.r, top, 24.r, 0.0),
    child: Row(
      children: [
        Expanded(
            child: Divider(
          height: 1.r,
          color: color,
        ))
      ],
    ),
  );
}

Widget _checkBoxLine(SignInController controller) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(width: Common.defaultMarginHor.r),
      InkWell(
        onTap: controller.toggleIdSave,
        child: Row(
          children: [
            Obx(
              () => controller.isIdSave.value
                  ? SvgPicture.asset(
                      'assets/icons/check_active.svg',
                      width: 22.r,
                      height: 22.r,
                      color: CommonColor.mainDarkGreen,
                    )
                  : SvgPicture.asset(
                      'assets/icons/check_inactive.svg',
                      width: 22.r,
                      height: 22.r,
                    ),
            ),
            SizedBox(width: 6.r),
            Text('아이디 저장', style: CommonTextStyle.b13(color: CommonColor.gray05))
          ],
        ),
      ),
      SizedBox(width: 16.r),
      InkWell(
        onTap: controller.toggleAutoLogin,
        child: Row(
          children: [
            Obx(
              () => controller.isAutoLogin.value
                  ? SvgPicture.asset(
                      'assets/icons/check_active.svg',
                      width: 22.r,
                      height: 22.r,
                      color: CommonColor.mainDarkGreen,
                    )
                  : SvgPicture.asset(
                      'assets/icons/check_inactive.svg',
                      width: 22.r,
                      height: 22.r,
                    ),
            ),
            SizedBox(width: 6.r),
            Text('자동 로그인', style: CommonTextStyle.b13(color: CommonColor.gray05))
          ],
        ),
      ),
    ],
  );
}

Widget _submitButton(SignInController controller, double top) {
  return Padding(
    padding: EdgeInsets.fromLTRB(24.r, top, 24.r, 0.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.r),
      child: Material(
        color: CommonColor.mainDarkGreen,
        child: InkWell(
          onTap: controller.submit,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.r, vertical: 16.r),
            child: Text(
              "로그인",
              style: CommonTextStyle.b05(color: Colors.white),
            ).c,
          ),
        ),
      ),
    ),
  );
}

Widget _findBar() {
  return Container(
    padding: EdgeInsets.fromLTRB(67.r, 16.r, 91.5.r, 0.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          child: Text(
            "로그인 정보를 잊으셨나요?",
            style: CommonTextStyle.b14(color: CommonColor.gray03),
          ),
          onTap: () {
            Get.toNamed('/find_ID_PW');
          },
        ),
        Container(
          width: 0.5.r,
          height: 13.r,
          color: CommonColor.gray02,
        ),
        InkWell(
          onTap: () {
            Get.toNamed('/register-step1');
          },
          child: Container(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "회원가입",
                style: CommonTextStyle.b14(color: CommonColor.gray03),
              )),
        ),
      ],
    ),
  );
}
