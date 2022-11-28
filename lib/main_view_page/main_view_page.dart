import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_app/common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/common/image_loader.dart';
import 'package:pet_app/common/service/auth_service.dart';
import 'package:pet_app/common/service/service_response.dart';
import 'package:pet_app/main_view_page/main_controller.dart';
import 'package:get/get.dart';
import 'package:pet_app/post_detail_view_page/post_detail_view_page.dart';
import 'package:pet_app/route/routes.dart';

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
          padding: EdgeInsets.symmetric(vertical: 24.r, horizontal: 24.r),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("KU",
                      // style: CommonTextStyle(fontSize: 40.r, fontWeight: FontWeight.w800, color: CommonColor.mainBGGreen.withAlpha(70)),
                      style: TextStyle(
                        fontSize: 40.r,
                        letterSpacing: -3.2,
                        fontWeight: FontWeight.w900,
                        color: CommonColor.mainBGGreen.withAlpha(70),
                      )),
                  Expanded(child: searchBar(textEditingController: controller.searchTextEditingController)),
                  if (!Get.find<AuthService>().authed)
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: IconButton(
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
                      ),
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
              child: Column(
                children: List.generate(controller.posts.length, (index) => Obx(() => _bodyFragment(controller.posts[index], index))),
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

  static Widget _bodyFragment(Post post, int index) {
    return InkWell(
      onTap: (() => Get.toNamed(PostDetailViewPage.url, arguments: PostDetailRouteParams(post: post))),
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
                  (post.detailString ?? ""),
                  maxLines: 4,
                  style: CommonTextStyle(fontSize: 11.r, color: CommonColor.gray03),
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
        padding: EdgeInsets.only(bottom: 0.r, top: 0.r, left: 12.r),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent, borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colors.transparent, width: 0.r)),
                    child: Center(
                      child: TextField(
                        style: CommonTextStyle(color: const Color(0xFF000000), fontSize: 16.r, fontWeight: FontWeight.w400),
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start,
                        controller: textEditingController,
                        decoration: InputDecoration(
                            fillColor: CommonColor.gray01,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent, width: 0.r),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent, width: 0.r),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            contentPadding: EdgeInsets.only(left: 64.r, right: 24.r, top: 11.r, bottom: 11.r),
                            border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide(color: Colors.transparent, width: 0.r)),
                            isDense: true,
                            hintText: "게시물 검색",
                            hintStyle: CommonTextStyle(color: const Color(0xFF000000).withOpacity(0.5), fontSize: 16.r, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 14.r),
                      child: SvgPicture.asset('assets/icons/search.svg', color: CommonColor.black),
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

class Post {
  String? nickname;
  String? profileImageUrl;
  String? time;
  String? major;
  int? age;
  String? detailString;
  String? title;
  Post({this.nickname, this.profileImageUrl, this.time, this.major, this.age, this.detailString, this.title});
}
