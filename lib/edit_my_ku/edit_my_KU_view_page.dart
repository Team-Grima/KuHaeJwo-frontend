import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/common/common.dart';
import 'package:get/get.dart';
import 'package:pet_app/edit_my_ku/edit_my_KU_controller.dart';

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
            body: Stack(children: [
              IntrinsicHeight(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.r, vertical: 10.r),
                child: Column(
                  children: [
                    dropdownButton(hint: controller.hintList[0], list: controller.college, v: controller.selectedIndexMap["소속 단과 대학"]!),
                    Obx(
                      () => dropdownButton(
                          hint: controller.hintList[1],
                          list: controller.department[controller.college[controller.selectedIndexMap["소속 단과 대학"]!.value ?? 0]] ?? [],
                          v: controller.selectedIndexMap["소속 학과"]!),
                    ),
                    dropdownButton(hint: controller.hintList[2], list: controller.hak, v: controller.selectedIndexMap["학번"]!),
                    dropdownButton(hint: controller.hintList[3], list: controller.age, v: controller.selectedIndexMap["나이"]!),
                    dropdownButton(hint: controller.hintList[4], list: controller.MBTI, v: controller.selectedIndexMap["MBTI"]!),
                    dropdownButton(hint: controller.hintList[5], list: controller.gender, v: controller.selectedIndexMap["성별"]!),
                  ],
                ),
              )),
              Common.BottomButton(context: context, numberOfButton: 1, buttonText1: '시작하기', button1Function: controller.submit),
            ])));
  }

  dropdownButton({required String hint, required List<String> list, required RxnInt v}) {
    EditMyKUController controller = Get.find<EditMyKUController>();

    return Obx(() => Container(
          padding: EdgeInsets.only(top: 16.r),
          child: DropdownButton2(
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(
                color: CommonColor.gray03, // red as border color
              ),
            ),

            hint: Text(
              hint,
              style: CommonTextStyle(color: CommonColor.gray03, fontSize: 17),
            ),
            value: v.value,
            items: List.generate(
                list.length,
                (listIndex) => DropdownMenuItem(
                    value: listIndex,
                    child: Text(
                      list[listIndex],
                      style: CommonTextStyle(color: CommonColor.black, fontSize: 17),
                    ))),
            onChanged: (value) {
              if (hint == "소속 단과 대학을 선택해주세요") {
                Get.find<EditMyKUController>().selectedIndexMap["소속 학과"]!.value = null;
              }
              if (value == null) {
              } else {
                v.value = value;
              }
            },
            buttonPadding: EdgeInsets.only(left: 0.r, right: 10.r),
            iconEnabledColor: Colors.grey, //Icon color
            style: CommonTextStyle(color: const Color(0xFF333333), fontSize: 15),
            underline: Container(), //remove underline
            isExpanded: true, //make true to make width 100%
            itemPadding: EdgeInsets.only(left: 20.r, right: 20.r, top: 0.r, bottom: 0.r),
          ),
        ));
  }
}
