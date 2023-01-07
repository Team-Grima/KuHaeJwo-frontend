import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kuhaejwo_app/common/common.dart';

import 'package:get/get.dart';
import 'package:kuhaejwo_app/pages/mate_offer/mate_offer_edit/mate_offer_edit_controller.dart';

class MateOfferEditViewPage extends StatelessWidget {
  const MateOfferEditViewPage({Key? key}) : super(key: key);
  static const url = '/edit-mate-offer';

  @override
  Widget build(BuildContext context) {
    MateOfferEditController controller = Get.put(MateOfferEditController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: CommonColor.white,
        appBar: CommonAppBar(
          context: context,
          title: "게시물 수정",
          // title: controller.authService.myMateOffer.value?.title ?? "제목이 없어요",
          // title: "내 쿠해줘 게시글 미리보기",
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Obx(
                () => controller.authService.userPrefer.value != null && controller.authService.myMateOffer.value != null
                    ? IntrinsicHeight(
                        child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 16.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headerTextEditingFragment(
                                  hintText: '게시글 제목을 입력해주세요',
                                  textEditingController: controller.headerEditingController,
                                  isValid: true.obs,
                                ),
                                SizedBox(height: 20.r),
                                bodyTextEditingFragment(
                                  hintText: controller.getBodyString() == "" ? "내용을 입력해주세요" : "body",
                                  textEditingController: controller.bodyEditingController,
                                  isValid: true.obs,
                                )
                              ],
                            ),
                          ),
                        ],
                      ))
                    : const Text("신규작성 필요.. 로그인필요.."),
              ),
            ),
            Common.BottomButton(
              context: context,
              numberOfButton: 2,
              buttonText1: "뒤로가기",
              button1Function: () => Get.back(),
              buttonText2: "저장하기",
              button2Function: controller.updateUserPost,
            ),
          ],
        ),
      ),
    );
  }

  headerTextEditingFragment({required String hintText, required RxBool isValid, required TextEditingController textEditingController}) {
    return Obx(
      () => TextField(
        keyboardType: TextInputType.multiline,
        controller: textEditingController,
        style: CommonTextStyle(fontSize: 14, color: CommonColor.black),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: isValid.value ? BorderSide(color: CommonColor.gray02, width: 1.5.r) : BorderSide(color: CommonColor.red, width: 1.r),
                borderRadius: BorderRadius.circular(5.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: isValid.value ? BorderSide(color: CommonColor.mainDarkGreen, width: 1.5.r) : BorderSide(color: CommonColor.red, width: 1.r),
                borderRadius: BorderRadius.circular(5.r)),
            contentPadding: EdgeInsets.symmetric(vertical: 5.5.r, horizontal: 14.r),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r)),
            hintText: hintText,
            hintStyle: CommonTextStyle(fontSize: 14, color: CommonColor.gray03),
            hintMaxLines: 1),
      ),
    );
  }

  bodyTextEditingFragment({required String hintText, required RxBool isValid, required TextEditingController textEditingController}) {
    return Obx(
      () => TextField(
        keyboardType: TextInputType.multiline,
        controller: textEditingController,
        style: CommonTextStyle(fontSize: 14, color: CommonColor.black),
        maxLines: 25,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: isValid.value ? BorderSide(color: CommonColor.gray02, width: 1.5.r) : BorderSide(color: CommonColor.red, width: 1.r),
                borderRadius: BorderRadius.circular(5.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: isValid.value ? BorderSide(color: CommonColor.mainDarkGreen, width: 1.5.r) : BorderSide(color: CommonColor.red, width: 1.r),
                borderRadius: BorderRadius.circular(5.r)),
            contentPadding: EdgeInsets.symmetric(vertical: 5.5, horizontal: 14.r),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r)),
            hintText: hintText,
            hintStyle: CommonTextStyle(fontSize: 14, color: CommonColor.gray03),
            hintMaxLines: 30),
      ),
    );
  }
}
