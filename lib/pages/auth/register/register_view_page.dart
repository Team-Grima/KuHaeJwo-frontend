import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/pages/auth/login/sign_in_controller.dart';
import 'package:pet_app/pages/auth/register/register_controller.dart';
import 'package:pet_app/common/common.dart';

/*
기본 left, right padding값: 24.r
*/

class RegisterViewPage extends StatelessWidget {
  const RegisterViewPage({Key? key}) : super(key: key);
  static const url = "/register";

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());
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
              CommonAppBar(context: context, title: '회원 가입', shadowColor: Colors.transparent),
              Row(
                children: [
                  _infoMessage('아이디(이메일)', CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CommonColor.gray03), 22.r),
                  const Expanded(child: SizedBox()),
                  _errorMessage(controller.emailWarning, CommonTextStyle.b14(color: CommonColor.red), 17.r)
                ],
              ),
              textInputWidget('아이디(이메일)를 입력하세요', controller.emailController, controller.isEmailValid, false, 4.r, controller),
              Row(
                children: [
                  _infoMessage('닉네임', CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CommonColor.gray03), 22.r),
                  const Expanded(child: SizedBox()),
                  _errorMessage(controller.nameWarning, CommonTextStyle.b14(color: CommonColor.red), 17.r)
                ],
              ),
              textInputWidget('닉네임를 입력하세요', controller.nameController, controller.isNameValid, false, 4.r, controller),
              Row(
                children: [
                  _infoMessage('비밀번호', CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CommonColor.gray03), 22.r),
                  const Expanded(child: SizedBox()),
                  _errorMessage(controller.pwdWarning, CommonTextStyle.b14(color: CommonColor.red), 17.r)
                ],
              ),
              textInputWidget('비밀번호를 입력하세요', controller.pwdController, controller.isPwdValid, true, 4.r, controller),
              Row(
                children: [
                  _infoMessage('비밀번호 재입력', CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CommonColor.gray03), 22.r),
                  const Expanded(child: SizedBox()),
                  _errorMessage(controller.pwdCheckWarning, CommonTextStyle.b14(color: CommonColor.red), 17.r)
                ],
              ),
              textInputWidget('비밀번호를 다시 한번 입력하세요', controller.pwdCheckController, controller.isPwdCheckValid, true, 4.r, controller),
              const Expanded(child: SizedBox()),
              Common.BottomButton(
                context: context,
                numberOfButton: 1,
                buttonText1: "회원가입",
                button1Function: () async {
                  if (controller.verifyStep1()) {
                    // Get.toNamed('/register-step2');
                    if (await controller.signUp()) {
                      Get.dialog(Common.commonModal(mainText: "회원가입 완료", numberOfButton: 1, button1Function: Get.back, button1Text: "로그인하러 가기"));
                      Get.find<SignInController>().idController.text = "";
                    }
                    Common.logger.d("all pass");
                  }
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

Widget textInputWidget(String hintText, TextEditingController textEditingController, RxBool isValid, bool isPwd, double top, RegisterController controller) {
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
                  visible: controller.isDeleteButtonVisibleMap[textEditingController]!.value,
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
                        ? controller.isSubmitButton1Clicked.value
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
// }

// Widget _bottomButton(RegisterController controller) {
//   return Row(
//     children: [
//       Expanded(
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: Common.defaultMarginHor.r, vertical: Common.defaultMarginVer.r),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: TextButton(
//                   onPressed: () {
//                     Get.dialog(
//                       Common.commonModal(
//                         mainText: '회원가입을 종료하시겠어요?',
//                         subText: '종료시 작성중인 내용이 삭제돼요.',
//                         button1Text: '아니요',
//                         button2Text: '종료할께요',
//                         button2Function: () {
//                           Get.offAllNamed('/home');
//                         },
//                       ),
//                     );
//                   },
//                   style: TextButton.styleFrom(
//                     foregroundColor: CommonColor.navy, padding: const EdgeInsets.all(18), // foreground
//                     backgroundColor: CommonColor.gray01,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//                   ),
//                   child: Text(
//                     "이전",
//                     style: CommonTextStyle.botton17(color: CommonColor.gray05),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 11.r),
//               Expanded(
//                 child: TextButton(
//                   onPressed: () async {
//                     if (await controller.verifyStep1()) {
//                       Get.toNamed('/register-step2');
//                     }
//                     controller.isSubmitButton1Clicked.value = true;
//                   },
//                   style: TextButton.styleFrom(
//                     foregroundColor: CommonColor.navy, padding: const EdgeInsets.all(18), // foreground
//                     backgroundColor: CommonColor.mainDarkGreen,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Common.defaultBorderRadius)),
//                   ),
//                   child: Text(
//                     "다음",
//                     style: CommonTextStyle.botton17(color: CommonColor.gray05),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
}
