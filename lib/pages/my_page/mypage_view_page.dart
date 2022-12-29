import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_app/common/common.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/utils/common_storage.dart';
import 'package:pet_app/common/utils/image_loader.dart';
import 'package:pet_app/pages/edit_my_ku/edit_my_KU_view_page.dart';
import 'package:pet_app/pages/my_page/mypage_controller.dart';
import 'package:pet_app/pages/survey_steps/room_mate_prefer_survey/roommate_survey_view_page.dart';
import 'package:pet_app/pages/survey_steps/survey_step_0/survey_step_1_view_page.dart';

class MyPageViewPage extends StatelessWidget {
  const MyPageViewPage({Key? key}) : super(key: key);
  static const url = '/my-page';
  @override
  Widget build(BuildContext context) {
    MyPageController controller = Get.put(MyPageController());
    return SafeArea(
        child: Scaffold(
            backgroundColor: CommonColor.white,
            appBar: CommonAppBar(
              backgroundColor: CommonColor.white,
              title: '마이페이지',
              context: context,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.r),
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
                                    Obx(
                                      () => CommonStorageKey.accessToken.read.value != null
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(5.r),
                                              child: Material(
                                                color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.6),
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.to(() => EditMyKUViewPage(
                                                          isEditForm: true,
                                                        ));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
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
                                                          controller.authService.userBasicInfo.value != null ? "수정" : "정보 입력하기",
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
                                          : Container(),
                                    ),
                                  ],
                                ),
                              ),
                              Obx(
                                () => controller.authService.userBasicInfo.value != null
                                    ? Column(
                                        children: [
                                          Row(
                                            children: [
                                              ImageLoader(
                                                // url: controller.authService.userData.value?.profileImageUrl ?? "",
                                                url: "https://enter.kku.ac.kr/mbshome/mbs/wwwkr/renewal/images/identity/ui_am.png",
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
                                                        controller.authService.userAuthInfo.value?.name ?? "삭제된 닉네임",
                                                        style: CommonTextStyle(fontSize: 18.r, color: CommonColor.white),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "${controller.authService.userBasicInfo.value?.age ?? 1}살",
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
                                                      controller.authService.userBasicInfo.value?.college ?? "",
                                                      style: CommonTextStyle(fontSize: 12.r, color: CommonColor.white),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      controller.authService.userBasicInfo.value?.department ?? "",
                                                      style: CommonTextStyle(fontSize: 12.r, color: CommonColor.white),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      controller.authService.userBasicInfo.value?.studentId ?? "",
                                                      style: CommonTextStyle(fontSize: 12.r, color: CommonColor.white),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 40.r, bottom: 75.r),
                                            child: Text(
                                              CommonStorageKey.accessToken.read.value == null ? "로그인이 필요합니다." : "우측 상단의 정보 입력하기 버튼으로 정보를 입력해주세요",
                                              style: CommonTextStyle(fontSize: 12.r, color: CommonColor.white),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IgnorePointer(
                            child: Image.asset(
                              "assets/images/konkuk_logo.png",
                              width: 170.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 16.r,
                  ),
                  checkbox("내 소개 수정하기", context),
                  checkbox(
                    "내가 원하는 룸메 수정하기",
                    context,
                  ),
                ],
              ),
            )));
  }

  checkbox(String header, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.r),
      child: InkWell(
        splashColor: Colors.black.withOpacity(0.05),
        onTap: () {
          if (header == "내 소개 수정하기") {
            Get.to(() => SurveyStep1ViewPage(isEditForm: true));
          } else {
            Get.to(() => RoomMateSurveyViewPage(isEditForm: true));
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
}
