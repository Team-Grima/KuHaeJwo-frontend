import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kuhaejwo_app/common/http_model/GetUserResponse.dart';
import 'package:kuhaejwo_app/common/utils/image_loader.dart';
import 'package:kuhaejwo_app/common/service/auth_service.dart';
import 'package:kuhaejwo_app/common/utils/service_response.dart';
import 'package:kuhaejwo_app/pages/main_view_page/main_controller.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/pages/user_post_view_page/user_post_view_page.dart';
import 'package:kuhaejwo_app/route/routes.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static const url = '/mainView';

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.put(MainController());
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.r, 24.r, 4.r, 24.r),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("KU",
                      // style: CommonTextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: CommonColor.mainBGGreen.withAlpha(70)),
                      style: TextStyle(
                        fontSize: 40.r,
                        letterSpacing: -3.2,
                        fontWeight: FontWeight.w900,
                        color: CommonColor.mainBGGreen.withAlpha(70),
                      )),
                  Expanded(
                    child: searchBar(textEditingController: controller.searchTextEditingController),
                  ),
                  if (!Get.find<AuthService>().authed)
                    IconButton(
                      splashRadius: 20.0.r,
                      onPressed: () {
                        Get.toNamed('/alarm');
                        // print("alert");
                      },
                      icon: GetBuilder<MainController>(builder: (homeController) {
                        return FutureBuilder(
                          builder: (context, AsyncSnapshot<ServiceResponse<bool>> snapshot) {
                            if (snapshot.hasData && (snapshot.data?.result ?? false) && snapshot.data?.value == true) {
                              return SvgPicture.asset('assets/icons/bell.svg');
                            } else if (snapshot.hasError || (snapshot.data?.result ?? false) == false) {
                              return SvgPicture.asset('assets/icons/nored_bell.svg');
                            } else {
                              return SvgPicture.asset('assets/icons/nored_bell.svg');
                            }
                          },
                          // future: HttpServiceManager().checkUnreadNotification(),
                        );
                      }),
                    )
                ],
              ),
            ],
          ),
        ),
        _selectFragment(controller: controller),
        Expanded(
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Obx(
                () => Column(
                  children: List.generate(controller.mateOfferList.length, (index) => _bodyFragment(controller.mateOfferList[index], index)),
                ),
              ),
            ),
          ),
        )
      ]),
    ));
  }

  _selectFragment({required MainController controller}) {
    return Container();
  }

  static Widget _bodyFragment(MateOfferResponse mateOffer, int index) {
    return InkWell(
      onTap: (() => Get.toNamed(UserPostViewPage.url, arguments: MateOfferUserParams(mateOffer: mateOffer))),
      child: Column(
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
                      // url: userDetailData.userProfileUrl ??''",
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
                              // userDetailData ?? "",
                              "RandomNickName",
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
                          "${mateOffer.userProfile?.department ?? ""}·${mateOffer.userProfile?.age ?? 20}살",
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
                  overflow: TextOverflow.visible,
                  mateOffer.body ?? "",
                  maxLines: 4,
                  style: CommonTextStyle(fontSize: 11, color: CommonColor.gray03),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => print('scrap'), child: const Text('스크랩')),
                    TextButton(onPressed: () => print('chat'), child: const Text('채팅하기')),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            height: 0,
          )
        ],
      ),
    );
  }

  static Widget searchBar({required textEditingController}) {
    return IntrinsicHeight(
      child: Padding(
        padding: EdgeInsets.only(left: 12.r),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent, borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colors.transparent, width: 0.r)),
                    child: const Center(
                      child: Text("게시물 검색"),
                      // child: TextField(
                      //   style: CommonTextStyle(color: const Color(0xFF000000), fontSize: 16, fontWeight: FontWeight.w400),
                      //   keyboardType: TextInputType.text,
                      //   textAlign: TextAlign.start,
                      //   controller: textEditingController,
                      //   decoration: InputDecoration(
                      //       fillColor: CommonColor.gray01,
                      //       filled: true,
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: Colors.transparent, width: 0.r),
                      //         borderRadius: BorderRadius.circular(20.r),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: Colors.transparent, width: 0.r),
                      //         borderRadius: BorderRadius.circular(20.r),
                      //       ),
                      //       contentPadding: EdgeInsets.only(left: 64.r, right: 24.r, top: 11.r, bottom: 11.r),
                      //       border:
                      //           OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide(color: Colors.transparent, width: 0.r)),
                      //       isDense: true,
                      //       hintText: "게시물 검색",
                      //       hintStyle: CommonTextStyle(color: const Color(0xFF000000).withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.w400)),
                      // ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 14.r),
                      child: InkWell(
                        onTap: () => Get.toNamed("/search"),
                        child: SvgPicture.asset('assets/icons/search.svg', color: CommonColor.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
