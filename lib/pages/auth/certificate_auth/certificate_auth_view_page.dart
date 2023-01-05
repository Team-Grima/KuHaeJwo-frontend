import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/pages/auth/certificate_auth/certificate_auth_controller.dart';

/*
기본 left, right padding값: 24.r
*/

class CertificateAuthViewPage extends StatelessWidget {
  const CertificateAuthViewPage({Key? key}) : super(key: key);
  static const url = "/certificate-auth";

  @override
  Widget build(BuildContext context) {
    final CertificateAuthController controller = Get.put(CertificateAuthController());
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

Widget _uploadButton(String text, CertificateAuthController controller) {
  return Padding(
    padding: EdgeInsets.all(20.r),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.r),
      child: Material(
        color: CommonColor.mainDarkGreen,
        child: InkWell(
          onTap: controller.fileUpload,
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
