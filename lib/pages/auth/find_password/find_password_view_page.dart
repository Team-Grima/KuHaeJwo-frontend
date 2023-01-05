import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kuhaejwo_app/pages/auth/find_password/find_password_controller.dart';

import 'package:kuhaejwo_app/common/common.dart';

/*
기본 left, right padding값: 24.r
*/

class FindPasswordViewPage extends StatelessWidget {
  const FindPasswordViewPage({Key? key}) : super(key: key);
  static const url = "/find-pw";

  @override
  Widget build(BuildContext context) {
    final FindPasswordController controller = Get.put(FindPasswordController());
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
              CommonAppBar(context: context, title: '아이디 / 비밀번호 찾기', shadowColor: Colors.transparent),
              Obx(
                () => controller.isSendPasswordBtnClicked.value
                    ? Container()
                    : Row(
                        children: [
                          _infoMessage('아이디(이메일)', CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CommonColor.gray03), 22.r),
                          const Expanded(child: SizedBox()),
                          _errorMessage(controller.emailWarning, CommonTextStyle.b14(color: CommonColor.red), 17.r)
                        ],
                      ),
              ),
              Obx(
                () => controller.isSendPasswordBtnClicked.value
                    ? Center(
                        child:
                            _infoMessage('임시 비밀번호가 메일로 전송되었습니다.', CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CommonColor.gray03), 22.r))
                    : textInputWidget('아이디(이메일)를 입력하세요', controller.emailController, controller.isEmailValid, false, 4.r, controller),
              ),
              const Expanded(child: SizedBox()),
              Obx(
                () => Common.BottomButton(
                  context: context,
                  numberOfButton: 1,
                  buttonColor1: controller.isSendPasswordBtnActive.value ? CommonColor.mainDarkGreen : CommonColor.disabledGrey,
                  buttonText1: controller.isSendBtnClicked.value ? "로그인하러 가기" : "이메일로 임시 비밀번호 발송",
                  button1Function: !controller.isSendPasswordBtnActive.value
                      ? null
                      : () {
                          controller.isSendBtnClicked.value = true;
                          if (controller.isSendPasswordBtnClicked.value) {
                            Get.back();
                          } else {
                            controller.findPWVerify();
                          }
                        },
                ),
              )
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

Widget textInputWidget(
    String hintText, TextEditingController textEditingController, RxBool isValid, bool isPwd, double top, FindPasswordController controller) {
  return Padding(
    padding: EdgeInsets.fromLTRB(24.r, top, 24.r, 0.0),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Obx(
          () => TextField(
            keyboardType: isPwd ? TextInputType.visiblePassword : TextInputType.emailAddress,
            obscureText: isPwd,
            controller: textEditingController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: isValid.value ? BorderSide(color: CommonColor.gray02, width: 0.5.r) : BorderSide(color: CommonColor.red, width: 1.r),
                  borderRadius: BorderRadius.circular(5.r)),
              focusedBorder: OutlineInputBorder(
                  borderSide: isValid.value ? BorderSide(color: CommonColor.mainDarkGreen, width: 1.r) : BorderSide(color: CommonColor.red, width: 1.r),
                  borderRadius: BorderRadius.circular(5.r)),
              contentPadding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 16.r),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r)),
              hintText: hintText,
              hintStyle: CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CommonColor.gray03),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 18.r),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: controller.isDeleteButtonVisible.value,
                  child: Padding(
                    padding: EdgeInsets.only(right: 6.r),
                    child: InkWell(
                      onTap: () {
                        if (textEditingController.text.isNotEmpty) {
                          textEditingController.clear();
                        }
                      },
                      child: SvgPicture.asset('assets/icons/xDeleteButton.svg', width: 16.r, height: 16.r),
                    ),
                  ),
                ),
                Container(
                  height: 22.r,
                  margin: EdgeInsets.only(right: 16.r),
                  child: InkWell(
                    onTap: () {},
                    child: isValid.value
                        ? controller.isSendPasswordBtnClicked.value
                            ? SvgPicture.asset('assets/icons/check.svg')
                            : Container()
                        : SvgPicture.asset('assets/icons/notCorrect_filled.svg'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
