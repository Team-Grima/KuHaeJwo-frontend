import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_app/common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/defaultPages/main_view_page/main_controller.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static const url = '/mainView';

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.put(MainController());
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.r, horizontal: 16.r),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("KU",
                  // style: CommonTextStyle(fontSize: 40.r, fontWeight: FontWeight.w800, color: CommonColor.mainBGGreen.withAlpha(70)),
                  style: TextStyle(
                      fontSize: 40.r,
                      letterSpacing: -3.2,
                      // wordSpacing: 0.3,
                      // height: 1.2,
                      fontWeight: FontWeight.w900,
                      color: CommonColor.mainBGGreen.withAlpha(70))),
              Expanded(child: searchBar(textEditingController: controller.searchTextEditingController)),
              SvgPicture.asset(
                'assets/icons/alarm_none.svg',
                color: Colors.black,
              ),
            ],
          )
        ]),
      ),
    ));
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
