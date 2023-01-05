import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/pages/auth/school_auth/school_auth_controller.dart';

import '../certificate_auth/certificate_auth_view_page.dart';

/*
기본 left, right padding값: 24.r
*/

class SchoolAuthViewPage extends StatelessWidget {
  const SchoolAuthViewPage({Key? key}) : super(key: key);
  static const url = "/school-auth";

  @override
  Widget build(BuildContext context) {
    final SchoolAuthController controller = Get.put(SchoolAuthController());
    return DefaultTextHeightBehavior(
      textHeightBehavior: const TextHeightBehavior(leadingDistribution: TextLeadingDistribution.even),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: CommonColor.white,
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              CommonAppBar(context: context, title: '학교 인증', shadowColor: Colors.transparent),
              Row(
                children: [
                  _infoMessage('학교 메일을 인증해주세요', CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CommonColor.black), 22.r),
                  const Expanded(child: SizedBox()),
                  _errorMessage(controller.emailWarning, CommonTextStyle.b14(color: CommonColor.red), 17.r)
                ],
              ),
              _emailInput("kimkonkuk@konkuk.ac.kr", controller.emailController, 16.r, 12.r),
              _authButton("인증하기", controller),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      height: 2.r,
                      color: CommonColor.gray03,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.r),
                    child: const Text(
                      "신입생인 경우",
                      style: TextStyle(color: CommonColor.gray03),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      height: 2.r,
                      color: CommonColor.gray03,
                    ),
                  ),
                ],
              ),
              _authButton("합격증으로 인증하기", controller),
            ],
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

Widget _errorMessage(RxString text, TextStyle style, double top) {
  return Obx(() => Padding(
        padding: EdgeInsets.fromLTRB(0.0, top, 24.r, 0.0),
        child: Row(children: [
          Text(
            text.value,
            style: style,
          ),
        ]),
      ));
}

Widget _emailInput(String hintText, TextEditingController controller, double top, double bottom) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16.r, top, 16.r, bottom),
    child: TextField(
      textInputAction: TextInputAction.done,
      style: CommonTextStyle.b04(),
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: CommonColor.gray02), borderRadius: BorderRadius.circular(5.r)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: CommonColor.mainMidGreen, width: 1.r), borderRadius: BorderRadius.circular(5.r)),
        contentPadding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 16.r),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r)),
        hintText: hintText,
        hintStyle: CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CommonColor.gray03),
      ),
    ),
  );
}

Widget _authButton(String text, SchoolAuthController controller) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16.r, 0.0, 16.r, 0.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.r),
      child: Material(
        color: CommonColor.mainDarkGreen,
        child: InkWell(
          onTap: text == "인증하기" ? controller.emailAuth : () => Get.to(() => const CertificateAuthViewPage()),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 12.r),
            child: Text(
              text,
              style: CommonTextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
            ).c,
          ),
        ),
      ),
    ),
  );
}
