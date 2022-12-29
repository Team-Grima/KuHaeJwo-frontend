import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/common/common.dart';

import 'package:get/get.dart';
import 'package:pet_app/common/http_model/GetUserResponse.dart';
import 'package:pet_app/common/utils/image_loader.dart';
import 'package:pet_app/pages/mate_offer/mate_offer_edit/mate_offer_edit_controller.dart';

class MateOfferEditViewPage extends StatelessWidget {
  const MateOfferEditViewPage({Key? key}) : super(key: key);
  static const url = '/edit-mate-offer';
  @override
  Widget build(BuildContext context) {
    MateOfferEditController controller = Get.put(MateOfferEditController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColor.white,
        appBar: CommonAppBar(
            context: context,
            // title: controller.post.title ?? "",
            title: "내 쿠해줘 게시글 수정하기"),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Obx(
                () => controller.authService.myMateOffer.value == null
                    ? const Text("신규작성 필요.. 로그인필요..")
                    : IntrinsicHeight(child: _bodyFragment(controller.authService.myMateOffer.value!)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _bodyFragment(MateOfferResponse mateOffer) {
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            mateOffer.title ?? "",
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
