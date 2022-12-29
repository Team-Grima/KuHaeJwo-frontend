import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_app/common/common.dart';

import 'package:get/get.dart';
import 'package:pet_app/common/http_model/GetUserResponse.dart';
import 'package:pet_app/common/service/auth_service.dart';
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
        appBar: CommonAppBar(
            context: context,
            // title: controller.post.title ?? "",
            title: "내 쿠해줘 게시글 미리보기",
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
                () => controller.authService.myMateOffer.value == null && controller.authService.userBasicInfo.value != null
                    ? const Text("신규작성 필요.. 로그인필요..")
                    : IntrinsicHeight(
                        child: _bodyFragment(controller.authService.myMateOffer.value!, controller.authService.userBasicInfo.value!, controller.authService)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _bodyFragment(MateOfferResponse mateOffer, UserBasicInfoResponse userBasicInfoResponse, AuthService authService) {
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
                            authService.userAuthInfo.value?.name ?? "",
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
                  mateOffer.title ?? "",
                  style: CommonTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              // ),
              Text(
                mateOffer.body ?? "",
                overflow: TextOverflow.visible,
                style: CommonTextStyle(fontSize: 14, color: CommonColor.gray03),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
