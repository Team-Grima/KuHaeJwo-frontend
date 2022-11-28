import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_app/common/common.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/image_loader.dart';
import 'package:pet_app/edit_my_ku/edit_my_KU_view_page.dart';
import 'package:pet_app/my_page/mypage_controller.dart';

class MyPageViewPage extends StatelessWidget {
  const MyPageViewPage({Key? key}) : super(key: key);
  static const url = '/my-page';
  @override
  Widget build(BuildContext context) {
    MyPageController controller = Get.put(MyPageController());
    return SafeArea(
        child: Scaffold(
            backgroundColor: CommonColor.white,
            appBar: AppBar(
              backgroundColor: CommonColor.white,
              elevation: 0,
              title: Center(
                child: Text(
                  '마이페이지',
                  style: CommonTextStyle(color: CommonColor.black, fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.r),
              child: Column(
                children: [
                  SizedBox(height: 20.r),
                  IntrinsicHeight(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: CommonColor.gray06,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: const Offset(0, 5), // changes position of shadow),
                              )
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.r),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8.0.r, bottom: 15.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "건국대학교",
                                      style: CommonTextStyle(color: CommonColor.white, fontSize: 12),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5.r),
                                      child: Material(
                                        color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.6),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                                            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 5.r),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/edit_pencil.png",
                                                  width: 8.r,
                                                  height: 8.r,
                                                ),
                                                SizedBox(width: 5.r),
                                                Text(
                                                  "수정",
                                                  style: CommonTextStyle(
                                                    color: CommonColor.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  ImageLoader(
                                    url: controller.user.value?.profileImageUrl ?? "",
                                    height: 50.r,
                                    width: 50.r,
                                  ),
                                  SizedBox(width: 10.r),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            controller.user.value?.username ?? "",
                                            style: CommonTextStyle(fontSize: 18.r, color: CommonColor.white),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${controller.user.value?.age ?? 1}살",
                                            style: CommonTextStyle(fontSize: 12.r, color: CommonColor.gray03),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 60.r),
                              Padding(
                                padding: EdgeInsets.only(bottom: 21.r),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          controller.user.value?.upperMajor ?? "",
                                          style: CommonTextStyle(fontSize: 12.r, color: CommonColor.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          controller.user.value?.major ?? "",
                                          style: CommonTextStyle(fontSize: 12.r, color: CommonColor.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          controller.user.value?.major ?? "",
                                          style: CommonTextStyle(fontSize: 12.r, color: CommonColor.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            "assets/images/konkuk_logo.png",
                            width: 170.r,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.r),
                  checkbox("내 소개 수정하기", context),
                  checkbox("내가 원하는 룸메 수정하기", context),
                ],
              ),
            )));
  }

  checkbox(String header, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.r),
      child: InkWell(
        splashColor: Colors.black.withOpacity(0.05),
        onTap: () {
          Get.toNamed(EditMyKUViewPage.url);
        },
        child: Container(
          decoration: BoxDecoration(color: CommonColor.disabledGrey, borderRadius: BorderRadius.circular(5.r)),
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
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
}
