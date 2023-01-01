import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pet_app/common/common.dart';
import 'package:pet_app/pages/auth/email_auth/email_auth_controller.dart';

import '../school_auth/school_auth_view_page.dart';

/*
기본 left, right padding값: 24.r
*/

class EmailAuthViewPage extends StatelessWidget {
  const EmailAuthViewPage({Key? key}) : super(key: key);
  static const url = "/email_auth";

  @override
  Widget build(BuildContext context) {
    final EmailAuthController controller = Get.put(EmailAuthController());
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
              CommonAppBar(context: context, title: '이메일 인증', shadowColor: Colors.transparent),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Icon(
                      Icons.mail_outline_rounded,
                      size: 100,
                    ),
                  ),
                  _infoMessage(
                    '인증 메일이',
                    CommonTextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: CommonColor.gray03),
                    0,
                  ),
                  _infoMessage(
                    Get.arguments,
                    CommonTextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: CommonColor.black),
                    0,
                  ),
                  _infoMessage(
                    '(으)로 전송되었습니다',
                    CommonTextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: CommonColor.gray03),
                    0,
                  ),
                  _infoMessage(
                    '받으신 이메일을 열어 링크를 클릭해주세요',
                    CommonTextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: CommonColor.gray03),
                    20,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: '이메일을 확인할 수 없나요?\n스팸편지함 확인 또는 ',
                          style: TextStyle(
                            color: CommonColor.gray03,
                          ),
                        ),
                        TextSpan(
                          text: '인증 메일 다시 보내기',
                          style: const TextStyle(
                            color: CommonColor.black,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(
                                  () => const SchoolAuthViewPage(),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _infoMessage(String text, TextStyle style, double top) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, top, 0.0, 0.0),
    child: Text(
      text,
      style: style,
    ),
  );
}
