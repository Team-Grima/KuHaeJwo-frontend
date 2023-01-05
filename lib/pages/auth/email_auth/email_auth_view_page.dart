import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/pages/auth/email_auth/email_auth_controller.dart';

/*
기본 left, right padding값: 24.r
*/

class EmailAuthViewPage extends StatelessWidget {
  const EmailAuthViewPage({Key? key}) : super(key: key);
  static const url = "/email-auth";

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
                  SizedBox(
                    height: 30.r,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.r),
                    child: Icon(
                      Icons.mail_outline_rounded,
                      size: 100.r,
                    ),
                  ),
                  _infoMessage(
                    '인증 메일이',
                    CommonTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: CommonColor.gray03,
                    ),
                    0.r,
                  ),
                  GestureDetector(
                    onTap: controller.onEmailTap,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: CommonColor.black,
                            width: 1.r,
                          ),
                        ),
                      ),
                      child: _infoMessage(
                        Get.arguments,
                        CommonTextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: CommonColor.black,
                        ),
                        0.r,
                      ),
                    ),
                  ),
                  _infoMessage(
                    '(으)로 전송되었습니다',
                    CommonTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: CommonColor.gray03,
                    ),
                    0.r,
                  ),
                  _infoMessage(
                    '받으신 이메일을 열어 링크를 클릭해주세요',
                    CommonTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: CommonColor.gray03,
                    ),
                    20.r,
                  ),
                  SizedBox(
                    height: 50.r,
                  ),
                  _infoMessage(
                    '이메일을 확인할 수 없나요?',
                    CommonTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: CommonColor.gray03,
                    ),
                    0.r,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _infoMessage(
                        '스팸편지함 확인 또는 ',
                        CommonTextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: CommonColor.gray03,
                        ),
                        0.r,
                      ),
                      GestureDetector(
                        onTap: controller.onResendTap,
                        child: _infoMessage(
                          '인증 메일 다시 보내기',
                          CommonTextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: CommonColor.black,
                          ),
                          0.r,
                        ),
                      ),
                    ],
                  ),

                  // RichText(
                  //   textAlign: TextAlign.center,
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: '이메일을 확인할 수 없나요?\n스팸편지함 확인 또는 ',
                  //         style: CommonTextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: CommonColor.gray03),
                  //       ),
                  //       TextSpan(
                  //         text: '인증 메일 다시 보내기',
                  //         style: CommonTextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: CommonColor.black),
                  //         recognizer: TapGestureRecognizer()
                  //           ..onTap = () => Get.to(
                  //                 () => const SchoolAuthViewPage(),
                  //               ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
    padding: EdgeInsets.only(top: top),
    child: Text(
      text,
      style: style,
    ),
  );
}
