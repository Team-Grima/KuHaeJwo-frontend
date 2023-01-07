import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kuhaejwo_app/common/common.dart';

import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/http_model/GetUserResponse.dart';
import 'package:kuhaejwo_app/common/utils/image_loader.dart';
import 'package:kuhaejwo_app/pages/mate_offer/mate_offer_create/mate_offer_controller.dart';
import 'package:kuhaejwo_app/pages/mate_offer/mate_offer_edit/mate_offer_edit_view_page.dart';
import 'package:kuhaejwo_app/pages/survey_steps/room_mate_prefer_survey/roommate_survey_view_page.dart';
import 'package:kuhaejwo_app/pages/survey_steps/user_detail_info/survey_step_1_view_page.dart';

class MateOfferViewPage extends StatelessWidget {
  const MateOfferViewPage({Key? key}) : super(key: key);
  static const url = '/create-mate-offer';
  @override
  Widget build(BuildContext context) {
    MateOfferController controller = Get.put(MateOfferController());
    return Scaffold(
      backgroundColor: CommonColor.white,
      appBar: CommonAppBar(
        context: context,
        title: "내 게시글",
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
                          // padding: EdgeInsets.only(top: 16.r, left: 24.r, right: 24.r),
                          padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 16.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              checkbox("새 게시글 작성하기", context),
                              checkbox(
                                "내 게시글 수정하기",
                                context,
                              ),
                              // makeContainer(
                              //   userProfileFragment(controller),
                              //   () => Get.to(
                              //     () => EditMyKUViewPage(isEditForm: true),
                              //   ),
                              // ),
                              mateOfferBodyFragment(controller.authService.myMateOffer.value!.body),
                              makeContainer(
                                userDetailInfoFragment(controller.authService.userInfoDetail.value!),
                                () => Get.to(
                                  () => SurveyStep1ViewPage(isEditForm: true),
                                ),
                              ),
                              SizedBox(height: 16.r),
                              makeContainer(
                                userPreferFragment(controller.authService.userPrefer.value!.preferList),
                                () => Get.to(
                                  () => RoomMateSurveyViewPage(isEditForm: true),
                                ),
                              ),
                              SizedBox(height: 16.r),
                              makeContainer(
                                userDetialExtraWordFragment(controller.authService.myMateOffer.value?.body ?? "내용이 없어요"),
                                () => Get.to(
                                  () => const MateOfferEditViewPage(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
                  : const Text("신규작성 필요.. 로그인필요.."),
            ),
          ),
        ],
      ),
    );
  }

  checkbox(String header, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.r),
      child: InkWell(
        splashColor: Colors.black.withOpacity(0.05),
        onTap: () {
          if (header == "게시글 작성하기") {
            Get.toNamed(MateOfferEditViewPage.url);
          } else if (header == "내 게시글 수정하기") {
            Get.toNamed(MateOfferEditViewPage.url);
          }
        },
        child: Container(
          decoration: BoxDecoration(color: CommonColor.gray01, borderRadius: BorderRadius.circular(5.r)),
          padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 8.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                header,
                style: CommonTextStyle(
                  color: CommonColor.black,
                  fontSize: 15,
                ),
              ).c,
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    // routeFunction(header, context, btnIndex, body);
                  },
                  child: SvgPicture.asset('assets/icons/right_arrow.svg'))
            ],
          ),
        ),
      ),
    );
  }

  userProfileFragment(MateOfferController controller) {
    return Row(
      children: [
        ImageLoader(
          // url: userDetailData.profileImageUrl ?? "",
          url: "https://enter.kku.ac.kr/mbshome/mbs/wwwkr/renewal/images/identity/ui_am.png",
          height: 38.r,
          width: 38.r,
        ),
        SizedBox(
          width: 12.r,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  controller.authService.userAuthInfo.value?.name ?? "",
                  style: CommonTextStyle(
                    fontSize: 13.r,
                  ),
                ),
                SizedBox(
                  width: 10.r,
                ),
                Text(
                  // post.time ?? "" == ,
                  "방금",
                  style: CommonTextStyle(fontSize: 10, color: CommonColor.disabledGrey),
                ),
              ],
            ),
            // Text(
            //   "${controller.authService.myMateOffer.value!.userProfile?.department ?? ""}·${controller.authService.myMateOffer.value!.userProfile?.age ?? -1}살",
            //   style: CommonTextStyle(fontSize: 11, color: CommonColor.gray03),
            // ),
            Text(
              "${controller.authService.userBasicInfo.value!.department ?? ""}·${controller.authService.userBasicInfo.value!.age ?? -1}살",
              style: CommonTextStyle(fontSize: 11, color: CommonColor.gray03),
            ),
          ],
        )
      ],
    );
  }

  mateOfferBodyFragment(String? title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 0.r),
      child: Text(
        title ?? "제목이 없어요",
        style: CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  userDetailInfoFragment(UserInfoDetailResponse userInfoDetailResponse) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "🙋🏻‍♀️ 저는요 !",
          overflow: TextOverflow.visible,
          style: CommonTextStyle(fontSize: 14, color: CommonColor.black),
        ),
        Text(
          generateDetailString(userInfoDetailResponse),
          style: CommonTextStyle(fontSize: 14, color: CommonColor.black),
        ),
      ],
    );
  }

  static String generateDetailString(UserInfoDetailResponse detail) {
    String res = "";
    res += "✅ ";
    res += detail.cleanHabit == "LAZY" ? "몰아서 치워요" : "바로 바로 치워요";
    res += "\n✅ ";
    res += detail.washingTime == "WAKE_UP"
        ? "보통은 일어나서 씻어요"
        : detail.washingTime == "BEFORE_SLEEP"
            ? "보통은 자기 전에 씻고 자요"
            : "아침 저녁으로 여러번 씻어요";
    res += "\n✅ ";
    res += detail.alcohol == "YES"
        ? "술을 마셔요"
        : detail.alcohol == "OFTEN"
            ? "술을 자주 마셔요"
            : "술을 마시지 않아요";
    res += "\n✅ ";
    res += detail.smoking == "YES" ? "담배를 피지 않아요 " : "흡연자에요";
    res += "\n✅ ";
    res += detail.sleepingTime == "BEFORE_12PM"
        ? "밤 열두시 전에 자요"
        : detail.sleepingTime == "AFTER_12PM"
            ? "밤 열두시 넘어서 자요"
            : "해뜨고나서.. 자요";
    res += "\n✅ ";
    res += detail.sleepingHabit == "SNORE"
        ? "코를 조금 골아요"
        : detail.sleepingHabit == "BRUXISM"
            ? "이를 좀 갈아요"
            : "잠버릇이 없어요";
    res += "\n✅ ";
    res += detail.sleeper == "LIGHT" ? "잠귀가 어두워서 잘 안깨요" : "잠귀가 밝아서 잘 깨요";
    res += "\n✅ ";
    res += detail.wakeUpTime == "BEFORE_AM09"
        ? "기상은 아침 9시 쯤 일어나요"
        : detail.wakeUpTime == "AROUND_AM12"
            ? "아침 12시 쯤 일어나요"
            : "오후에 일어나요";
    res += "\n✅ ";
    res += detail.alarm == "YES" ? "알람은 잘 듣는 편이에요" : "알람은 잘 못 듣는 편이에요";
    res += "\n✅ ";
    res += detail.outing == "MORE" ? "밖에 있는 시간이 많아요" : "집에 있는 시간이 많아요";
    res += "\n✅ ";
    res += detail.bug == "YES" ? "벌레를 잘 잡아요" : "벌레는 무서워서 못 잡아요";
    res += "\n✅ ";
    res += detail.temperature == "COLD"
        ? "추위를 많이 타요"
        : detail.temperature == "HEAT"
            ? "더위를 많이 타요"
            : "추운거 더운거 상관없어요";
    res += "\n✅ ";
    res += detail.friend == "BEST_FRIEND" ? "룸메와 베프가 되고 싶어요" : "룸메랑은 거리가 필요해요";
    return res;
  }

  userPreferFragment(List<String>? preferList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "👭🏻 이런 룸메를 원해요 !",
          overflow: TextOverflow.visible,
          style: CommonTextStyle(fontSize: 14, color: CommonColor.black),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: preferList?.map((item) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 6.0.r),
                      child: Padding(
                        padding: EdgeInsets.all(5.r),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: Material(
                            color: CommonColor.disabledGrey,
                            child: InkWell(
                              // onTap: () {
                              //   controller.addSelectedPrefer(item);
                              // },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 4.r),
                                child: Text(
                                  "# $item",
                                  style: CommonTextStyle(fontSize: 13, color: Colors.black),
                                ).c,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList() ??
              [],
        ),
      ],
    );
  }

  Widget userDetialExtraWordFragment(String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "👭🏻 하고 싶은 말",
          overflow: TextOverflow.visible,
          style: CommonTextStyle(fontSize: 14, color: CommonColor.black),
        ),
        Text(
          body,
          overflow: TextOverflow.visible,
          style: CommonTextStyle(fontSize: 14, color: CommonColor.black),
        ),
      ],
    );
  }

  Widget makeContainer(Widget widget, Function() function) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.r)),
      child: Material(
        color: CommonColor.gray01,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                  onTap: function,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
                    child: widget,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
