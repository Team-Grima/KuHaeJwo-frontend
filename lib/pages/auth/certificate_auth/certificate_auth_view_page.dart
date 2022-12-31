import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pet_app/common/common.dart';
import 'package:pet_app/pages/auth/school_auth/school_auth_controller.dart';

/*
기본 left, right padding값: 24.r
*/

class CertificateAuthViewPage extends StatelessWidget {
  const CertificateAuthViewPage({Key? key}) : super(key: key);
  static const url = "/certificate_auth";

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
              CommonAppBar(context: context, title: '합격증 인증', shadowColor: Colors.transparent),
              Row(
                children: [
                  _infoMessage('합격증 사진을 업로드해주세요', CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CommonColor.black), 22.r),
                ],
              ),
              _uploadButton("파일 선택하기", controller),
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

Widget _uploadButton(String text, SchoolAuthController controller) {
  return Padding(
    padding: EdgeInsets.all(20.r),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.r),
      child: Material(
        color: CommonColor.mainDarkGreen,
        child: InkWell(
          onTap: text == "인증하기" ? controller.submit : () => Get.to(() => const CertificateAuthViewPage()),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 16.r),
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
