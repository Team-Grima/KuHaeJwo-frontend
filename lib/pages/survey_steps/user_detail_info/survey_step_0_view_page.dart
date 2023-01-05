import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/pages/survey_steps/user_detail_info/survey_controller.dart';
import 'package:kuhaejwo_app/pages/survey_steps/user_detail_info/survey_step_1_view_page.dart';

class SurveyViewPage extends StatelessWidget {
  const SurveyViewPage({Key? key}) : super(key: key);
  static const url = '/survey';
  @override
  Widget build(BuildContext context) {
    SurveyController controller = Get.put(SurveyController());
    return Scaffold(
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.r,
              ),
              Text('🙋🏻\n', style: CommonTextStyle(color: CommonColor.gray03, fontSize: 50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: ' 지금부터 나의 ', style: CommonTextStyle(color: CommonColor.gray03, fontSize: 18)),
                        TextSpan(text: '생활 패턴', style: CommonTextStyle(color: CommonColor.black, fontSize: 18, fontWeight: FontWeight.w500)),
                        TextSpan(text: "에 대한\n", style: CommonTextStyle(color: CommonColor.gray03, fontSize: 18)),
                        TextSpan(text: '문항을 선택합니다\n\n', style: CommonTextStyle(color: CommonColor.gray03, fontSize: 18)),
                        TextSpan(text: '대답한 문항은 게시글을 올릴 때나\n', style: CommonTextStyle(color: CommonColor.gray03, fontSize: 18)),
                        TextSpan(text: '마이페이지에서\n', style: CommonTextStyle(color: CommonColor.gray03, fontSize: 18)),
                        TextSpan(text: '수정 / 삭제가 가능', style: CommonTextStyle(color: CommonColor.black, fontSize: 18, fontWeight: FontWeight.w500)),
                        TextSpan(text: '하니\n 편하게 답해주세요!', style: CommonTextStyle(color: CommonColor.gray03, fontSize: 18)),
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
              Get.to(() => SurveyStep1ViewPage());
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
    );
  }
}
