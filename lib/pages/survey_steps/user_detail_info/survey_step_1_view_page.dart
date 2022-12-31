import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:pet_app/common/common.dart';
import 'package:get/get.dart';
import 'package:pet_app/pages/survey_steps/user_detail_info/survey_controller.dart';

class SurveyStep1ViewPage extends StatelessWidget {
  SurveyStep1ViewPage({Key? key, this.isEditForm = false}) : super(key: key);
  static const url = '/survey-1';
  bool isEditForm;
  @override
  Widget build(BuildContext context) {
    SurveyController controller = Get.put(SurveyController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColor.white,
        appBar: CommonAppBar(
          context: context,
          title: "내 소개 하기",
        ),
        body: Stack(children: [
          Obx(
            () => controller.currentStep.value == -1
                ? Container()
                : Column(
                    children: [
                      LinearProgressBar(
                        maxSteps: controller.maxStep,
                        progressType: LinearProgressBar.progressTypeDots,
                        currentStep: controller.currentStep.value,
                        progressColor: CommonColor.mainDarkGreen,
                        backgroundColor: CommonColor.gray01,
                        dotsAxis: Axis.horizontal, // OR Axis.vertical
                        dotsActiveSize: 10,
                        dotsInactiveSize: 10,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),

                        dotsSpacing: const EdgeInsets.only(right: 10), // also can use any EdgeInsets.
                      ),
                      SizedBox(
                        height: 0.4.sh,
                        child: questionFregment(
                          controller.getCurrent(),
                        ),
                      ),
                      SizedBox(
                        height: 0.4.sh,
                        child: answerListFregment(controller.getCurrent(), controller),
                      ),
                    ],
                  ),
          ),
          Obx(
            () => Common.BottomButton(
              context: context,
              numberOfButton: 1,

              buttonText1: controller.currentStep.value == controller.maxStep - 1 ? "저장하기" : '이전',
              // buttonText2: '다음',
              button1Function: controller.currentStep.value == controller.maxStep - 1 ? controller.saveConfigs : controller.prevStep,
              // button2Function: controller.nextStep,
            ),
          ),
        ]),
      ),
    );
  }
}

Widget questionFregment(SurveyInfo current) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.r),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${current.icon}\n', style: CommonTextStyle(color: CommonColor.black, fontSize: 50)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              current.question,
              style: CommonTextStyle(color: CommonColor.black, fontSize: 20, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget answerListFregment(SurveyInfo current, SurveyController controller) {
  return GetBuilder<SurveyController>(
    builder: (controller) {
      return Column(
        children: List.generate(
          current.enumList.length,
          (index) => Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 4.r),
                  child: TextButton(
                    onPressed: () {
                      controller.selectSurveyItem(current, current.enumList[index]);
                      Future.delayed(const Duration(milliseconds: 200)).then((value) {
                        controller.nextStep();
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: CommonColor.gray03, padding: EdgeInsets.all(10.r), // foreground
                      backgroundColor: current.userSelect == current.enumList[index] ? CommonColor.mainDarkGreen : CommonColor.gray01,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                    ),
                    child: Text(
                      current.ansMap[current.enumList[index]] ?? "",
                      style: CommonTextStyle(
                          color: current.userSelect == current.enumList[index] ? CommonColor.white : CommonColor.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
