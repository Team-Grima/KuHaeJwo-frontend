import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/pages/survey_steps/user_detail_info/edit_user_detail_info_controller.dart';

class EditUserDetailInfoViewPage extends StatelessWidget {
  EditUserDetailInfoViewPage({Key? key, this.isEditForm = false}) : super(key: key);
  static const url = '/edit-survey';
  bool isEditForm;
  @override
  Widget build(BuildContext context) {
    EditUserDetailController controller = Get.put(EditUserDetailController());
    return Scaffold(
      backgroundColor: CommonColor.white,
      appBar: CommonAppBar(
        context: context,
        title: "내 소개 하기",
      ),
      body: Stack(children: [
        SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            children: [
              ...List.generate(
                controller.maxStep,
                (index) {
                  return userDetailSelectFragment(index, controller, controller.surveyList[index]);
                },
              ),
              SizedBox(height: 70.r)
            ],
          ),
        ),
        Common.BottomButton(
          gradientVisible: true,
          context: context,
          numberOfButton: 1,
          buttonText1: '저장하기',
          button1Function: controller.saveConfigs,
        ),
      ]),
    );
  }
}

userDetailSelectFragment(int index, EditUserDetailController controller, SurveyInfo surveyInfo) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 12.r),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(surveyInfo.icon, style: CommonTextStyle(color: CommonColor.black, fontSize: 30)),
            Text(
              surveyInfo.question,
              style: CommonTextStyle(color: CommonColor.black, fontSize: 15, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<EditUserDetailController>(builder: (controller) {
                return Wrap(
                  children: List.generate(
                    surveyInfo.enumList.length,
                    (innerIndex) {
                      return Padding(
                        padding: EdgeInsets.only(right: 6.r),
                        child: TextButton(
                          onPressed: () {
                            controller.selectSurveyItem(surveyInfo, surveyInfo.enumList[innerIndex]);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: CommonColor.gray03, padding: EdgeInsets.all(8.r), // foreground
                            backgroundColor: surveyInfo.userSelect == surveyInfo.enumList[innerIndex] ? CommonColor.mainDarkGreen : CommonColor.gray01,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                          ),
                          child: Text(
                            surveyInfo.ansMap[surveyInfo.enumList[innerIndex]] ?? "",
                            style: CommonTextStyle(
                                color: surveyInfo.userSelect == surveyInfo.enumList[innerIndex] ? CommonColor.white : CommonColor.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      );
                    },
                  ),
                );
              })
            ],
          ),
        )
      ],
    ),
  );
}

// Widget questionFregment(SurveyInfo current) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 16.r),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text('${current.icon}\n', style: CommonTextStyle(color: CommonColor.black, fontSize: 50)),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               current.question,
//               style: CommonTextStyle(color: CommonColor.black, fontSize: 20, fontWeight: FontWeight.w400),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

// Widget answerListFregment(SurveyInfo current, SurveyController controller) {
//   return GetBuilder<SurveyController>(
//     builder: (controller) {
//       return Column(
//         children: List.generate(
//           current.enumList.length,
//           (index) => Row(
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 4.r),
//                   child: TextButton(
//                     onPressed: () {
//                       controller.selectSurveyItem(current, current.enumList[index]);
//                       Future.delayed(const Duration(milliseconds: 200)).then((value) {
//                         controller.nextStep();
//                       });
//                     },
//                     style: TextButton.styleFrom(
//                       foregroundColor: CommonColor.gray03, padding: EdgeInsets.all(10.r), // foreground
//                       backgroundColor: current.userSelect == current.enumList[index] ? CommonColor.mainDarkGreen : CommonColor.gray01,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
//                     ),
//                     child: Text(
//                       current.ansMap[current.enumList[index]] ?? "",
//                       style: CommonTextStyle(
//                           color: current.userSelect == current.enumList[index] ? CommonColor.white : CommonColor.black,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
