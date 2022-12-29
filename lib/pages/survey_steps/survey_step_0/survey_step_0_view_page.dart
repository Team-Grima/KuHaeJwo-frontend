import 'package:flutter/material.dart';
import 'package:pet_app/common/common.dart';
import 'package:get/get.dart';
import 'package:pet_app/pages/survey_steps/survey_step_0/survey_controller.dart';

import 'survey_step_1_view_page.dart';

class SurveyViewPage extends StatelessWidget {
  const SurveyViewPage({Key? key}) : super(key: key);
  static const url = '/survey';
  @override
  Widget build(BuildContext context) {
    SurveyController controller = Get.put(SurveyController());
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
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('🙋🏻\n', style: CommonTextStyle(color: CommonColor.gray03, fontSize: 50)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: ' 지금부터 나의 ', style: CommonTextStyle(color: CommonColor.gray03, fontSize: 18)),
                          TextSpan(text: '생활 패턴', style: CommonTextStyle(color: CommonColor.black, fontSize: 18, fontWeight: FontWeight.w600)),
                          TextSpan(text: "에 대한\n", style: CommonTextStyle(color: CommonColor.gray03, fontSize: 18)),
                          TextSpan(text: '문항을 선택합니다\n\n', style: CommonTextStyle(color: CommonColor.gray03, fontSize: 18)),
                          TextSpan(text: '대답한 문항은 게시글을 올릴 때나', style: CommonTextStyle(color: CommonColor.gray03, fontSize: 18)),
                          // TextSpan(text: '대답한 문항은 게시글을 올릴 때나', style: CommonTextStyle(color: CommonColor.gray03, fontSize: 18)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
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
