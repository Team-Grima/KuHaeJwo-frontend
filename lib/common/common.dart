import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class Common {
  static final f = NumberFormat('###,###,###,###');
  static const String baseUrl = "http://13.209.48.23";

  static const double defaultMarginHor = 24.0;
  static const double defaultMarginVer = 24.0;
  static const double defaultBorderRadius = 16.0;

  static final Common _instance = Common._internal();

  static final Logger logger = Logger();

  factory Common() {
    return _instance;
  }

  Common._internal();

  static EdgeInsets get sbMargin {
    return EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r);
  }

  static double get sbBorderRadius {
    return 5.r;
  }

  static showSnackbar({required String message}) {
    Get.rawSnackbar(
      borderRadius: sbBorderRadius,
      margin: Common.sbMargin,
      backgroundColor: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      messageText: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  static Widget infoMessage(String text, TextStyle style, double top) {
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

  static Widget errorMessage(String text, TextStyle style, double topMargin) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, topMargin, 24.r, 0.0),
      child: Row(children: [
        Text(
          text,
          style: style,
        ),
      ]),
    );
  }

  static Widget textInput(
      {required String hintText,
      required TextEditingController textEditingController,
      required double top,
      required TextInputType keyboardType,
      required String errMsg}) {
    return Padding(
      padding: EdgeInsets.only(left: 24.r, right: 24.r, top: top),
      child: TextField(
        keyboardType: keyboardType,
        controller: textEditingController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: errMsg == '' ? BorderSide(color: CommonColor.gray02, width: 0.5.r) : BorderSide(color: CommonColor.red, width: 1.r),
              borderRadius: BorderRadius.circular(16.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: errMsg == '' ? BorderSide(color: CommonColor.gray02, width: 0.5.r) : BorderSide(color: CommonColor.red, width: 1.r),
              borderRadius: BorderRadius.circular(16.r),
            ),
            contentPadding: EdgeInsets.only(left: 24.r, top: 15.r, bottom: 15.5.r, right: 24.r),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
            hintText: hintText,
            hintStyle: CommonTextStyle.b04(color: CommonColor.gray02)),
      ),
    );
  }

  //onTap 안에 사용하고 싶은 경우 Get.Dialog를 사용하시면 됩니다.
  static Widget commonModal({
    required String mainText,
    String subText = '',
    int numberOfButton = 2,
    Color button1Color = CommonColor.mainDarkGreen,
    Color button2Color = CommonColor.redError,
    String button1Text = '이전',
    String button2Text = '확인',
    Color button1TextColor = CommonColor.white,
    Color button2TextColor = CommonColor.red,
    String button1RoutePath = '',
    String button2RoutePath = '',
    void Function()? button1Function,
    void Function()? button2Function,
  }) {
    return IntrinsicWidth(
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        backgroundColor: CommonColor.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 22.r, bottom: 6.r),
                  child: Text(
                    mainText,
                    style: CommonTextStyle(fontSize: 16, color: CommonColor.gray06, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 30,
                  ),
                ),
                subText == ''
                    ? const SizedBox()
                    : Text(
                        subText,
                        style: CommonTextStyle.b07(color: CommonColor.gray05),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 30,
                      ),
                Padding(
                  padding: EdgeInsets.only(top: 17.r, bottom: 16.r),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.r),
                          child: Material(
                            color: button1Color,
                            child: InkWell(
                              onTap: () {
                                button1RoutePath == '' ? Get.back(result: false) : Get.toNamed(button1RoutePath);
                                if (button1Function != null) {
                                  button1Function();
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.r),
                                child: Text(
                                  button1Text,
                                  style: CommonTextStyle(fontSize: 16, color: button1TextColor, fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 30,
                                ).c,
                              ),
                            ),
                          ),
                        ),
                      ),
                      numberOfButton == 2 ? SizedBox(width: 8.r) : const SizedBox(),
                      numberOfButton == 2
                          ? Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: Material(
                                  color: button2Color,
                                  child: InkWell(
                                    onTap: () {
                                      button2RoutePath == '' ? Get.back(result: true) : Get.toNamed(button2RoutePath);
                                      if (button2Function != null) {
                                        button2Function();
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12.r),
                                      child: Text(
                                        button2Text,
                                        style: CommonTextStyle(fontSize: 16, color: button2TextColor, fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 30,
                                      ).c,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget commonModalVertical({
    required String mainText,
    required String subText,
    int numberOfButton = 2,
    Color button1Color = CommonColor.gray01,
    Color button2Color = CommonColor.redError,
    String button1Text = '이전',
    String button2Text = '확인',
    Color button1TextColor = CommonColor.gray03,
    Color button2TextColor = CommonColor.red,
    String button1RoutePath = '',
    String button2RoutePath = '',
    void Function()? button1Function,
    void Function()? button2Function,
  }) {
    return IntrinsicWidth(
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        backgroundColor: CommonColor.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 22.r, bottom: 6.r),
                  child: Text(
                    mainText,
                    style: CommonTextStyle.h05(color: CommonColor.gray06),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 30,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 17.r),
                  child: Text(
                    subText,
                    style: CommonTextStyle.b07(color: CommonColor.gray05),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 30,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.r),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Material(
                            color: button1Color,
                            child: InkWell(
                              onTap: () {
                                button1RoutePath == '' ? Get.back() : Get.toNamed(button1RoutePath);
                                if (button1Function != null) {
                                  button1Function();
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.r),
                                child: Text(
                                  button1Text,
                                  style: CommonTextStyle.botton02(color: button1TextColor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 30,
                                ).c,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                numberOfButton == 2
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 16.r),
                        child: Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: Material(
                                  color: button2Color,
                                  child: InkWell(
                                    onTap: () {
                                      button2RoutePath == '' ? Get.back() : Get.toNamed(button2RoutePath);
                                      if (button2Function != null) {
                                        button2Function();
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16.r),
                                      child: Text(
                                        button2Text,
                                        style: CommonTextStyle.botton02(color: button2TextColor),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 30,
                                      ).c,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget BottomButton({
    Key? key,
    required BuildContext context,
    numberOfButton = 2, // 버튼의 개수를 정해주는 변수입니다. 디폴트는 2개고 1개일 때 1개의 버튼이 나오고 나머지는 전부 2개 버튼으로 생성시켜 줍니다.
    buttonColor1 = CommonColor.mainDarkGreen, // 버튼 1의 색상입니다. 디폴트 그레이 고 설정으로 바꿔줄 수 있습니다.
    buttonColor2 = CommonColor.mainMidGreen, // 버튼 2의 색상입니다. 디폴트 그레이 고 설정으로 바꿔줄 수 있습니다.
    textColor1 = CommonColor.white, // 버튼 1의 텍스트색상 입니다.
    textColor2 = CommonColor.white, // 버튼 2의 텍스트색상 입니다.
    isButton1Active = true,
    isButton2Active = true,
    buttonText1 = '이전', // 버튼 1의 텍스트입니다.
    buttonText2 = '다음', // 버튼 1의 텍스트입니다.
    gradientVisible = false,
    void Function()? button1Function,
    void Function()? button2Function,
    double verticalPaddding = 12.0,
    double horizontalPaddding = 16.0,
  }) {
    if (numberOfButton == 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            height: MediaQuery.of(context).viewInsets.bottom <= 0 ? null : 0.r,
            child: Stack(
              children: [
                gradientVisible == true
                    ? Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 24.r,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Colors.white.withOpacity(0),
                                      Colors.white.withOpacity(1),
                                    ], // red to yellow
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      )
                    : const SizedBox(),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPaddding.r, vertical: verticalPaddding.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: button1Function,
                                style: TextButton.styleFrom(
                                  foregroundColor: CommonColor.navy, padding: EdgeInsets.all(10.r), // foreground
                                  backgroundColor: buttonColor1,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                                ),
                                child: Text(
                                  buttonText1,
                                  style: CommonTextStyle(color: textColor1, fontSize: 13, fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            height: MediaQuery.of(context).viewInsets.bottom <= 0 ? null : 0.r,
            child: Stack(
              children: [
                gradientVisible == true
                    ? Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 24.r,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Colors.white.withOpacity(0),
                                      Colors.white.withOpacity(1),
                                    ], // red to yellow
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      )
                    : const SizedBox(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: horizontalPaddding.r, vertical: verticalPaddding.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: button1Function,
                                style: TextButton.styleFrom(
                                  foregroundColor: CommonColor.navy, padding: EdgeInsets.all(10.r), // foreground
                                  backgroundColor: buttonColor1,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                                ),
                                child: Text(
                                  buttonText1,
                                  style: CommonTextStyle(color: textColor1, fontSize: 13, fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            SizedBox(width: 11.r),
                            Expanded(
                              child: TextButton(
                                onPressed: button2Function,
                                style: TextButton.styleFrom(
                                  foregroundColor: CommonColor.navy,
                                  padding: EdgeInsets.all(10.r),
                                  backgroundColor: buttonColor2,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                                ),
                                child: Text(
                                  buttonText2,
                                  style: CommonTextStyle(color: textColor1, fontSize: 14, fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    }
  }

  // static double getScaleWidth(BuildContext context) {
  //   // 사용중인 휴대폰의 비율과 디자인한 휴대폰의 비율을 나누어 위젯 크기 조절에 사용되는 api입니다. 휴대폰의 가로 길이만 가능합니다.
  //   const designGuideWidth = 375.0;
  //   final diff = MediaQuery.of(context).size.width / designGuideWidth;
  //   return diff;
  // }

  // static double getWidthValue(BuildContext context, double value) {
  //   // 위 함수로 구한 비율로 매개변수로 들어온 값과 곱해주어 반환시켜 줍니다. 휴대폰의 가로 길이만 가능합니다.
  //   double scaleWidth = Common.getScaleWidth(context);
  //   final diff = scaleWidth * value;
  //   return diff;
  // }

  // static double getScaleHeight(BuildContext context) {
  //   // 위에 getScaleWidth와 기능이 같지만 가로 비율 대신 세로 비율을 구해줍니다.
  //   const designGuideHeight = 812;
  //   final diff = MediaQuery.of(context).size.height / designGuideHeight;
  //   return diff;
  // }

  // static double getHeightValue(BuildContext context, double value) {
  //   // 위에 getWidthValue와 기능이 동일합니다만 가로 길이가 아닌 세로 길이를 구합니다.
  //   double scaleHeight = Common.getScaleHeight(context);
  //   final diff = scaleHeight * value;
  //   return diff;
  // }
}

class CommonColor {
  static const black = Color.fromARGB(255, 0, 0, 0);
  static const mainDarkGreen = Color(0xFF005426);
  static const mainMidGreen = Color(0xFF005426);
  static const disabledGrey = Color(0xFFd9d9d9);
  static const mainBGGreen = Color(0xFF005426);
  static const redError = Color(0xFFFF656E);
  static const red = Color(0xFFFB4E4E);

  static const darkGray = Color(0xFF999999);
  static const gray06 = Color(0xFF33334A);
  static const gray05 = Color(0xFF4C4C67);
  static const gray04 = Color(0xFF787886);
  static const gray03 = Color(0xFF90909F);
  static const gray02 = Color(0xFFC8C8D2);
  static const gray01 = Color(0xFFF3F3F3);
  static const navy = Color(0xFF000046);
  static const white = Color(0xFFFFFFFF);
}

extension TextExtension on Text {
  Center get c => Center(child: this);
}

dynamic commonSnackBar(
    {required String messageText, Color textColor = CommonColor.black, Color backgroundColor = CommonColor.mainBGGreen, dynamic position = SnackPosition.TOP}) {
  Get.rawSnackbar(
    borderRadius: 8.r,
    snackPosition: position,
    margin: position == SnackPosition.BOTTOM ? EdgeInsets.only(top: 16.r, left: 16.r, right: 16.r) : EdgeInsets.symmetric(vertical: 16.r, horizontal: 16.r),
    padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 16.r),
    messageText: Text(
      messageText,
      style: CommonTextStyle.botton02(color: CommonColor.black),
    ),
    backgroundColor: CommonColor.mainBGGreen,
  );
}

class CommonTextStyle extends TextStyle {
  CommonTextStyle({Color? color = Colors.black, TextDecoration? decoration = TextDecoration.none, double? fontSize, double? height, FontWeight? fontWeight})
      : super(color: color, fontFamily: 'NotoSansKR', fontSize: fontSize!.sp, height: height, fontWeight: fontWeight, decoration: decoration);

  CommonTextStyle.h01({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 31, fontWeight: FontWeight.w600, height: 1.61);

  CommonTextStyle.h02({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 26, fontWeight: FontWeight.w700, height: 1.35);

  CommonTextStyle.h03({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 22, fontWeight: FontWeight.w700, height: 1.41);

  CommonTextStyle.h04({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 22, fontWeight: FontWeight.w600, height: 1.59);

  CommonTextStyle.h05({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 20, fontWeight: FontWeight.w700, height: 0.85);

  CommonTextStyle.h06({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 20, fontWeight: FontWeight.w600, height: 1.60);

  CommonTextStyle.h07({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 18, fontWeight: FontWeight.w700, height: 1.61);

  CommonTextStyle.h08({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 18, fontWeight: FontWeight.w600, height: 1.61);

  CommonTextStyle.h09({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 17, fontWeight: FontWeight.w700, height: 1.47);

  CommonTextStyle.h10({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 17, fontWeight: FontWeight.w600, height: 1.24);

  CommonTextStyle.b01({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 32, fontWeight: FontWeight.w400, height: 1.57);

  CommonTextStyle.b02({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 29, fontWeight: FontWeight.w500, height: 1.61);

  CommonTextStyle.b03({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 17, fontWeight: FontWeight.w500, height: 1.47);

  CommonTextStyle.b04({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 17, fontWeight: FontWeight.w400, height: 1.47);

  CommonTextStyle.b05({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 15, fontWeight: FontWeight.w700, height: 1.60);

  CommonTextStyle.b06({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 15, fontWeight: FontWeight.w600, height: 1.60);

  CommonTextStyle.b07({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 15, fontWeight: FontWeight.w500, height: 1.60);

  CommonTextStyle.b08({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 15, fontWeight: FontWeight.w400, height: 1.60);

  CommonTextStyle.b09({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 14, fontWeight: FontWeight.w600, height: 1.57);

  CommonTextStyle.b10({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 14, fontWeight: FontWeight.w500, height: 1.57);

  CommonTextStyle.b11({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 14, fontWeight: FontWeight.w400, height: 1.50);

  CommonTextStyle.b12({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 13, fontWeight: FontWeight.w600, height: 1.62);

  CommonTextStyle.b13({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 13, fontWeight: FontWeight.w500, height: 1.62);

  CommonTextStyle.b14({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 13, fontWeight: FontWeight.w400, height: 1.46);

  CommonTextStyle.b15({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 12, fontWeight: FontWeight.w600, height: 1.67);

  CommonTextStyle.b16({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 11, fontWeight: FontWeight.w400, height: 1.73);

  CommonTextStyle.botton01({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 18, fontWeight: FontWeight.w500, height: 1.61);

  CommonTextStyle.botton02({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 17, fontWeight: FontWeight.w600, height: 1.41);

  CommonTextStyle.botton03({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 15, fontWeight: FontWeight.w600, height: 1.60);

  CommonTextStyle.botton04({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 13, fontWeight: FontWeight.w600, height: 1.62);

  CommonTextStyle.botton05({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 12, fontWeight: FontWeight.w600, height: 1.67);

  CommonTextStyle.botton12({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 12, fontWeight: FontWeight.w600, height: 1.60);

  CommonTextStyle.botton15({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 15, fontWeight: FontWeight.w600, height: 1.60);

  CommonTextStyle.botton17({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 17, fontWeight: FontWeight.w600, height: 1.41);

  CommonTextStyle.botton18({Color color = Colors.black, TextDecoration decoration = TextDecoration.none})
      : this(decoration: decoration, color: color, fontSize: 12, fontWeight: FontWeight.w400, height: 2.08);
}

// extension DoubleExtension on double {
//   double w(BuildContext context) => Common.getWidthValue(context, this);
//   double h(BuildContext context) => Common.getHeightValue(context, this);
// }

// extension IntExtension on int {
//   double w(BuildContext context) => Common.getWidthValue(context, this * 1.0);
//   double h(BuildContext context) => Common.getHeightValue(context, this * 1.0);
// }

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonAppBar({
    Key? key,
    required BuildContext context,
    required this.title,
    this.backgroundColor = Colors.white,
    this.titleColor = CommonColor.black,
    this.shadowColor = Colors.transparent,
    this.iconColor = CommonColor.gray03,
    this.leadingAssetPath = 'assets/icons/appbar_back.svg',
    this.actions,
    this.shape,
    this.onTapFunction,
    this.hasGetBack = false,
  }) :
        // : preferredSize = Size(1.sw, 88.r),
        super(key: key);

  @override
  final Size preferredSize = AppBar(
    leading: Container(
      margin: EdgeInsets.only(left: 16.r),
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 14.r),
          child: SvgPicture.asset('assets/icon/appbar_close.svg', width: 12.r, height: 20.r),
        ),
      ),
    ),
  ).preferredSize;
  final Color backgroundColor;
  final Color shadowColor;
  final Color titleColor;
  final Color iconColor;
  final ShapeBorder? shape;
  final String title;
  final String leadingAssetPath;
  final List<Widget>? actions;
  void Function()? onTapFunction;
  final bool hasGetBack;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: Common.defaultMarginHor.r,
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: backgroundColor,
      shape: shape,
      shadowColor: shadowColor,
      title: Text(title,
          style: CommonTextStyle(
            color: titleColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          )),
      // leading: hasGetBack
      //     ? Container(
      //         margin: EdgeInsets.only(left: 18.r),
      //         child: InkWell(
      //           onTap: hasGetBack ? Get.back : onTapFunction!,
      //           child: Padding(
      //             padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 15.r),
      //             child: SvgPicture.asset(
      //               leadingAssetPath,
      //               width: 12.r,
      //               height: 20.r,
      //               color: iconColor,
      //             ),
      //           ),
      //         ),
      //       )
      //     : null,
      // actions: actions,
    );
  }
}

extension ImageUrlExtension on String {
  String get getUrl => Common.baseUrl + this;
}

extension IntegerExtension on int {
  String get format => Common.f.format(this);
}

extension FutureExtension<T> on Future<T> {
  Future<T> load() async {
    Get.dialog(
      Center(
        child: CupertinoActivityIndicator(
          radius: 22.r,
          color: CommonColor.mainDarkGreen,
        ),
      ),
      barrierDismissible: false,
    );

    whenComplete(() {
      Get.until((route) => !Get.isDialogOpen!);
    });

    catchError((e) {
      Common.showSnackbar(message: "오류가 발생했습니다");
      throw e;
    });

    return this;
  }
}
