import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/login/login_controller.dart';

class ChangePWViewPage extends StatelessWidget {
  static const String url = "/login";
  const ChangePWViewPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ChangePasswordController controller = Get.put(ChangePasswordController());
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
              CommonAppBar(context: context, title: '비밀번호 변경', shadowColor: Colors.transparent),
              Row(
                children: [
                  _infoMessage('현재 비밀번호', CommonTextStyle.b06(color: CommonColor.gray03), 24.r),
                  const Expanded(child: SizedBox()),
                  _errorMessage(controller.currentPasswordWarninng, CommonTextStyle.b14(color: CommonColor.red), 27.r)
                ],
              ),
              textInputWidget('-없이 입력없이 입력하세요', controller.currentPassword, controller.currentPasswordValid, false, 12.r, controller),
              Row(
                children: [
                  _infoMessage('비밀번호', CommonTextStyle.b06(color: CommonColor.gray03), 32.r),
                  const Expanded(child: SizedBox()),
                  _errorMessage(controller.newPasswordWarninng, CommonTextStyle.b14(color: CommonColor.red), 27.r)
                ],
              ),
              textInputWidget('-없이 입력없이 입력하세요', controller.newPassword, controller.newPasswordValid, true, 12.r, controller),
              Row(
                children: [
                  _infoMessage('비밀번호 재입력', CommonTextStyle.b06(color: CommonColor.gray03), 32.r),
                  const Expanded(child: SizedBox()),
                  _errorMessage(controller.checkNewPasswordWarninng, CommonTextStyle.b14(color: CommonColor.red), 27.r)
                ],
              ),
              textInputWidget('-없이 입력없이 입력하세요', controller.checkNewPassword, controller.checkNewPasswordValid, true, 12.r, controller),
              const Expanded(child: SizedBox()),
              Common.BottomButton(
                context: context,
                numberOfButton: 1,
                buttonColor1: controller.isAllPassing ? CommonColor.darkGray : CommonColor.gray01,
                buttonText1: '변경',
                textColor1: controller.isAllPassing ? CommonColor.navy : CommonColor.gray03,
                isButton1Active: controller.isAllPassing,
                button1Function: () {
                  // controller.submit();
                },
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
    String hintText, TextEditingController textEditingController, RxBool isValid, bool isPwd, double top, ChangePasswordController controller) {
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
                  borderSide: isValid.value ? BorderSide(color: CommonColor.gray02, width: 0.5.r) : BorderSide(color: CommonColor.red, width: 1.r),
                  borderRadius: BorderRadius.circular(5.r)),
              contentPadding: EdgeInsets.symmetric(vertical: 15.5.r, horizontal: 24.r),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
              hintText: hintText,
              hintStyle: CommonTextStyle.b03(color: CommonColor.gray03),
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
                  visible: controller.isDeleteButtonVisibleMap[textEditingController]!.value,
                  child: Padding(
                    padding: EdgeInsets.only(right: 6.r),
                    child: InkWell(
                      onTap: () {
                        if (textEditingController.text.isNotEmpty) {
                          textEditingController.clear();
                        }
                      },
                      child: SvgPicture.asset('assets/icon/xDeleteButton.svg', width: 16.r, height: 16.r),
                    ),
                  ),
                ),
                Container(
                  height: 22.r,
                  margin: EdgeInsets.only(right: 16.r),
                  child: InkWell(
                    onTap: () {},
                    child: isValid.value ? const SizedBox() : SvgPicture.asset('assets/icon/notCorrect_filled.svg'),
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
