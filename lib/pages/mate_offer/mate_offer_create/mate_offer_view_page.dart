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
                () => controller.authService.myMateOffer.value == null || controller.authService.userBasicInfo.value == null
                    ? const Text("신규작성 필요.. 로그인필요..")
                    : IntrinsicHeight(child: _bodyFragment(controller.authService.myMateOffer.value!, controller.authService.userBasicInfo.value!, controller)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _bodyFragment(MateOfferResponse mateOffer, UserBasicInfoResponse userBasicInfoResponse, MateOfferController controller) {
    return Column(
      children: [
        Padding(
          // padding: EdgeInsets.only(top: 16.r, left: 24.r, right: 24.r),
          padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                        "${mateOffer.userProfile?.department ?? ""}·${mateOffer.userProfile?.age ?? -1}살",
                        style: CommonTextStyle(fontSize: 11, color: CommonColor.gray03),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 0.r),
                // child: Expanded(
                child: Text(
                  mateOffer.body ?? "하고싶은말이 없어요",
                  style: CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              // ),
              Text(
                "🙋🏻‍♀️ 저는요 !",
                overflow: TextOverflow.visible,
                style: CommonTextStyle(fontSize: 14, color: CommonColor.black),
              ),
              Text(
                "\n\n✅ 청소는 이틀에 한번 정도해요\n✅ 음주는 3일에 한번 정도 하는 편이에요\n✅ 주사는 귀여운 정도!\n✅ 흡연은 하지 않아요\n✅ 취침시간은 보통 오후 10~12시에요\n✅ 기상시간은 보통 오전 9~11시에요\n",
                overflow: TextOverflow.visible,
                style: CommonTextStyle(fontSize: 14, color: CommonColor.black),
              ),
              Text(
                mateOffer.body ?? "",
                overflow: TextOverflow.visible,
                style: CommonTextStyle(fontSize: 14, color: CommonColor.gray03),
              ),
              Text(
                "👭🏻 이런 룸메를 원해요 !",
                overflow: TextOverflow.visible,
                style: CommonTextStyle(fontSize: 14, color: CommonColor.black),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.selectedPrefer.map((item) {
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
                  }).toList())
            ],
          ),
        ),
      ],
    );
  }
}
