import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/pages/survey_steps/room_mate_prefer_survey/roommate_survey_controller.dart';

class RoomMateSurveyViewPage extends StatelessWidget {
  RoomMateSurveyViewPage({Key? key, required this.isEditForm}) : super(key: key);
  static const url = '/room-mate-survey';
  bool isEditForm;
  @override
  Widget build(BuildContext context) {
    RoomMateSurveyController controller = Get.put(RoomMateSurveyController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColor.white,
        appBar: CommonAppBar(
          context: context,
          title: "내 룸메 선택하기",
          hasGetBack: false,
          onTapFunction: Get.back,
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('👭🏻\n', style: CommonTextStyle(color: CommonColor.gray03, fontSize: 50)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '내 룸메가 갖고 있었으면 하는\n생활 패턴을 골라주세요\n',
                        style: CommonTextStyle(color: CommonColor.gray03, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    direction: Axis.horizontal,
                    children: controller.preferList.map((item) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 6.0.r),
                            child: Padding(
                                padding: EdgeInsets.all(5.r),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Obx(
                                    () => Material(
                                      color: controller.isSelectedPrefer(item) ? CommonColor.mainDarkGreen : CommonColor.gray01,
                                      child: InkWell(
                                        onTap: () {
                                          controller.addSelectedPrefer(item);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 4.r),
                                          child: Text(
                                            "# $item",
                                            style: CommonTextStyle(fontSize: 13, color: controller.isSelectedPrefer(item) ? Colors.white : Colors.black),
                                          ).c,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Obx(() => Common.BottomButton(
                    context: context,
                    numberOfButton: 1,
                    buttonText1: '저장하기',
                    isButton1Active: controller.isPass.value,
                    button1Function: controller.isPass.value ? controller.submit : null,
                    buttonColor1: controller.isPass.value ? CommonColor.mainDarkGreen : CommonColor.disabledGrey)
                // Common.BottomButton(
                //   context: context,
                //   numberOfButton: 2,
                //   buttonText1: '이전',
                //   buttonText2: '시작하기',
                //   buttonColor1: CommonColor.disabledGrey,
                // )
                ),
          ],
        ),
      ),
    );
  }
}
