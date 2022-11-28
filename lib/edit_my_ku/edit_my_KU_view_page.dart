import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/common/common.dart';
import 'package:get/get.dart';
import 'package:pet_app/edit_my_ku/edit_my_KU_controller.dart';
import 'package:pet_app/survey_page/survey_view_page.dart';

class EditMyKUViewPage extends StatelessWidget {
  const EditMyKUViewPage({Key? key}) : super(key: key);
  static const url = '/edit-my-kue';
  @override
  Widget build(BuildContext context) {
    EditMyKUController controller = Get.put(EditMyKUController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColor.white,
        appBar: CommonAppBar(
          context: context,
          title: "내 소개 하기",
          hasGetBack: false,
          onTapFunction: Get.back,
        ),
        body: Stack(
          children: [
            IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.r, vertical: 10.r),
                child: Column(
                  children: List.generate(
                    controller.dropDownListMap.keys.length,
                    ((keyIndex) => Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 16.r, bottom: 8.r),
                                child: Text(
                                  controller.dropDownListMap.keys.toList()[keyIndex],
                                  style: CommonTextStyle(color: CommonColor.gray03, fontSize: 17),
                                ),
                              ),
                              DropdownButton2(
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                    color: CommonColor.gray03, // red as border color
                                  ),
                                ),

                                hint: Text(
                                  controller.hintList[keyIndex],
                                  style: CommonTextStyle(color: CommonColor.gray03, fontSize: 17),
                                ),
                                value: controller.selectedIndexMap[controller.dropDownListMap.keys.toList()[keyIndex]]!.value,
                                items: List.generate(
                                    controller.dropDownListMap[controller.dropDownListMap.keys.toList()[keyIndex]]!.length,
                                    (listIndex) => DropdownMenuItem(
                                        value: listIndex,
                                        child: Text(
                                          (controller.dropDownListMap[controller.dropDownListMap.keys.toList()[keyIndex]])![listIndex],
                                          style: CommonTextStyle(color: CommonColor.black, fontSize: 17),
                                        ))),
                                onChanged: (value) {
                                  if (value == null) {
                                  } else {
                                    controller.selectedIndexMap[controller.dropDownListMap.keys.toList()[keyIndex]]!.value = value;
                                  }
                                },
                                buttonPadding: EdgeInsets.only(left: 0.r, right: 10.r),
                                iconEnabledColor: Colors.grey, //Icon color
                                style: CommonTextStyle(color: const Color(0xFF333333), fontSize: 15),
                                underline: Container(), //remove underline
                                isExpanded: true, //make true to make width 100%
                                itemPadding: EdgeInsets.only(left: 20.r, right: 20.r, top: 0.r, bottom: 0.r),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            ),
            Common.BottomButton(context: context, numberOfButton: 1, buttonText1: '시작하기', button1Function: () => Get.toNamed(SurveyViewPage.url))
          ],
        ),
      ),
    );
  }
}
