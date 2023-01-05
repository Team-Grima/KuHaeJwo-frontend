import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/pages/search/search_controller.dart';

class SearchViewPage extends StatelessWidget {
  const SearchViewPage({Key? key}) : super(key: key);
  static const url = '/search';

  @override
  Widget build(BuildContext context) {
    SearchController controller = Get.put(SearchController());
    return Container(
      color: CommonColor.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CommonColor.white,
          body: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: searchBar(
                      textEditingController: controller.searchTextEditingController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100.r),
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.search,
                      size: 50.r,
                      color: CommonColor.gray02,
                    ),
                    const Text(
                      "게시물을 검색해보세요",
                      style: TextStyle(color: CommonColor.gray02, fontSize: 14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget searchBar({required textEditingController}) {
    return IntrinsicHeight(
      child: Padding(
        padding: EdgeInsets.all(12.r),
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
                        style: CommonTextStyle(color: const Color(0xFF000000), fontSize: 16, fontWeight: FontWeight.w400),
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start,
                        controller: textEditingController,
                        autofocus: true,
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
                            hintStyle: CommonTextStyle(color: const Color(0xFF000000).withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        margin: EdgeInsets.only(left: 14.r),
                        child: const Icon(Icons.arrow_back),
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
