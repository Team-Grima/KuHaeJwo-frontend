import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_app/common/common.dart';

import 'package:get/get.dart';
import 'package:pet_app/common/http_model/GetUserResponse.dart';
import 'package:pet_app/common/utils/image_loader.dart';
import 'package:pet_app/pages/mate_offer/mate_offer_create/mate_offer_controller.dart';
import 'package:pet_app/pages/mate_offer/mate_offer_edit/mate_offer_edit_view_page.dart';

class MateOfferViewPage extends StatelessWidget {
  const MateOfferViewPage({Key? key}) : super(key: key);
  static const url = '/create-mate-offer';
  @override
  Widget build(BuildContext context) {
    MateOfferController controller = Get.put(MateOfferController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColor.white,
        appBar: CommonAppBar(context: context, title: controller.authService.myMateOffer.value?.title ?? "제목이 없어요",
            // title: "내 쿠해줘 게시글 미리보기",
            actions: [
              Container(
                margin: EdgeInsets.only(left: 18.r),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(MateOfferEditViewPage.url);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.r, horizontal: 12.r),
                    child: SvgPicture.asset(
                      "assets/icons/edit_mate_offer_button.svg",
                      color: CommonColor.black,
                    ),
                  ),
                ),
              )
            ]),
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
                            padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 24.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                userProfileFragment(controller),
                                mateOfferBodyFragment(controller.authService.myMateOffer.value!.body),
                                userDetailInfoFragment(controller.authService.userInfoDetail.value!),
                                userPreferFragment(controller.authService.userPrefer.value!.preferList),
                                Text(
                                  controller.authService.myMateOffer.value!.body ?? "",
                                  overflow: TextOverflow.visible,
                                  style: CommonTextStyle(fontSize: 14, color: CommonColor.gray03),
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
            Text(
              "${controller.authService.myMateOffer.value!.userProfile?.department ?? ""}·${controller.authService.myMateOffer.value!.userProfile?.age ?? -1}살",
              style: CommonTextStyle(fontSize: 11, color: CommonColor.gray03),
            ),
          ],
        )
      ],
    );
  }

  mateOfferBodyFragment(String? body) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 0.r),
      child: Text(
        body ?? "하고싶은말이 없어요",
        style: CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w400),
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
          generateDetailStirng(userInfoDetailResponse),
          style: CommonTextStyle(fontSize: 14, color: CommonColor.black),
        ),
      ],
    );
  }

  generateDetailStirng(UserInfoDetailResponse detail) {
    String res = "";
    res += "✅";
    res += detail.cleanHabit == "LAZY" ? "몰아서 치워요" : "바로 바로 치워요";
    res += "\n✅";
    res += detail.washingTime == "WAKE_UP"
        ? "보통은 일어나서 씻어요"
        : detail.washingTime == "BEFORE_SLEEP"
            ? "보통은 자기 전에 씻고 자요"
            : "아침 저녁으로 여러번 씻어요";
    res += "\n✅";
    res += detail.alcohol == "YES"
        ? "술을 마셔요"
        : detail.alcohol == "OFTEN"
            ? "술을 자주 마셔요"
            : "술을 마시지 않아요";
    res += "\n✅";
    res += detail.smoking == "YES" ? "담배를 피지 않아요 " : "흡연자에요";
    res += "\n✅";
    res += detail.sleepingTime == "BEFORE_12PM"
        ? "밤 열두시 전에 자요"
        : detail.sleepingTime == "AFTER_12PM"
            ? "밤 열두시 넘어서 자요"
            : "해뜨고나서.. 자요";
    res += "\n✅";
    res += detail.sleepingHabit == "SNORE"
        ? "코를 조금 골아요"
        : detail.sleepingHabit == "BRUXISM"
            ? "이를 좀 갈아요"
            : "잠버릇이 없어요";
    res += "\n✅";
    res += detail.sleeper == "LIGHT" ? "잠귀가 어두워서 잘 안깨요" : "잠귀가 밝아서 잘 깨요";
    res += "\n✅";
    res += detail.wakeUpTime == "BEFORE_AM09"
        ? "기상은 아침 9시 쯤 일어나요"
        : detail.wakeUpTime == "AROUND_AM12"
            ? "아침 12시 쯤 일어나요"
            : "오후에 일어나요";
    res += "\n✅";
    res += detail.alarm == "" ? "" : "";
    res += "\n✅";
    res += detail.outing == "" ? "" : "";
    res += "\n✅";
    res += detail.bug == "" ? "" : "";
    res += "\n✅";
    res += detail.temperature == "" ? "" : "";
    res += "\n✅";
    res += detail.friend == "" ? "" : "";
    res += "\n✅";
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
                            color: CommonColor.gray01,
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
}
