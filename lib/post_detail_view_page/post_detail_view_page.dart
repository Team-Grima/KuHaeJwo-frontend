import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_app/common/common.dart';

import 'package:get/get.dart';
import 'package:pet_app/common/image_loader.dart';
import 'package:pet_app/main_view_page/main_view_page.dart';
import 'package:pet_app/post_detail_view_page/post_detail_controller.dart';

class PostDetailViewPage extends StatelessWidget {
  const PostDetailViewPage({Key? key}) : super(key: key);
  static const url = '/post-detail';

  @override
  Widget build(BuildContext context) {
    PostDetailController controller = Get.put(PostDetailController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColor.white,
        appBar: CommonAppBar(
          context: context,
          // title: controller.post.title ?? "",
          title: "",
          hasGetBack: false,
          onTapFunction: Get.back,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: IntrinsicHeight(child: _bodyFragment(controller.post)),
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
                                      style: CommonTextStyle(color: CommonColor.black, fontSize: 18.r, fontWeight: FontWeight.w500),
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
                                      style: CommonTextStyle(color: CommonColor.black, fontSize: 18.r, fontWeight: FontWeight.w500),
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

  static Widget _bodyFragment(Post post) {
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
                    url: post.profileImageUrl ?? "",
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
                            post.nickname ?? "",
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
                            style: CommonTextStyle(fontSize: 10.r, color: CommonColor.disabledGrey),
                          ),
                        ],
                      ),
                      Text(
                        "${post.major ?? ""}·${post.age ?? -1}살",
                        style: CommonTextStyle(fontSize: 11.r, color: CommonColor.gray03),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 0.r),
                // child: Expanded(
                child: Text(
                  post.title ?? "",
                  style: CommonTextStyle(fontSize: 14.r, fontWeight: FontWeight.w500),
                ),
              ),
              // ),
              Text(
                overflow: TextOverflow.visible,
                '''✅ 청소는 이틀에 한번 정도해요
✅ 음주는 3일에 한번 정도 하는 편이에요
✅ 주사는 귀여운 정도!
✅ 흡연은 하지 않아요
✅ 취침시간은 보통 오후 10~12시에요
✅ 기상시간은 보통 오전 9~11시에요
''',
                style: CommonTextStyle(fontSize: 14.r, color: CommonColor.gray03),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
