import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_app/common/common.dart';

import 'package:get/get.dart';
import 'package:pet_app/common/http_model/GetUserResponse.dart';
import 'package:pet_app/common/utils/image_loader.dart';
import 'package:pet_app/pages/user_post_view_page/user_post_controller.dart';

class UserPostViewPage extends StatelessWidget {
  const UserPostViewPage({Key? key}) : super(key: key);
  static const url = '/user-post';
  @override
  Widget build(BuildContext context) {
    UserPostController controller = Get.put(UserPostController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColor.white,
        appBar: CommonAppBar(
          context: context,
          // title: controller.post.title ?? "",
          title: "",

          // onTapFunction: Get.back,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: IntrinsicHeight(child: _bodyFragment(controller.mateOffer)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  height: 1.r,
                  color: CommonColor.disabledGrey,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 0.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    foregroundColor: CommonColor.navy,
                                    padding: EdgeInsets.all(18.r),
                                    backgroundColor: Colors.transparent,
                                    shape: const RoundedRectangleBorder(side: BorderSide.none)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/bottom_chat.svg",
                                      color: CommonColor.black,
                                    ),
                                    SizedBox(width: 10.r),
                                    Text(
                                      "스크랩",
                                      style: CommonTextStyle(color: CommonColor.black, fontSize: 18, fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    foregroundColor: CommonColor.navy,
                                    padding: EdgeInsets.all(18.r),
                                    backgroundColor: CommonColor.white,
                                    shape: const RoundedRectangleBorder(side: BorderSide.none)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/bottom_chat.svg",
                                      color: CommonColor.black,
                                    ),
                                    SizedBox(width: 10.r),
                                    Text(
                                      "채팅하기",
                                      style: CommonTextStyle(color: CommonColor.black, fontSize: 18, fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
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
