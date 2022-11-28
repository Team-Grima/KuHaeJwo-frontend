import 'package:flutter/material.dart';
import 'package:pet_app/common/common.dart';
import 'package:get/get.dart';
import 'package:pet_app/survey_page/survey_controller.dart';

class SurveyStep1ViewPage extends StatelessWidget {
  const SurveyStep1ViewPage({Key? key}) : super(key: key);
  static const url = '/survey-1';
  @override
  Widget build(BuildContext context) {
    SurveyController controller = Get.find<SurveyController>();
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
            Column(
                // _question(),
                // ...List.generate(controller.steps[1].length, (index) => null)
                ),
            Common.BottomButton(
              context: context,
              numberOfButton: 1,
              buttonText1: '시작하기',
              button1Function: () {
                Get.toNamed(SurveyStep1ViewPage.url);
              },
            )
            // Common.BottomButton(
            //   context: context,
            //   numberOfButton: 2,
            //   buttonText1: '이전',
            //   buttonText2: '시작하기',
            //   buttonColor1: CommonColor.disabledGrey,
            // )
          ],
        ),
      ),
    );
  }
}
