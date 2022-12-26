import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/service/http_service_manager.dart';
import 'package:pet_app/main_view_page/main_view_page.dart';

class MainController extends GetxController {
  TextEditingController searchTextEditingController = TextEditingController();
  HttpServiceManager httpServiceManager = HttpServiceManager();
  RxList<Post> posts = <Post>[].obs;
  @override
  void onInit() {
    // posts.value = httpServiceManager.getPosts();
    posts.add(Post(
        age: 10,
        nickname: "asdf",
        profileImageUrl: "https://picsum.photos/id/237/200/300",
        detailString: '''🙋🏻‍♀️ 저는요 !
청소주기 : 이틀에 한번
음주여부 : 예
음주빈도 : 3일에 한번 
''',
        major: "소프트웨어학부",
        time: "2000-10-10 1000",
        title: "레이크홀 여자 룸메이트 구해요"));

    posts.add(Post(
        age: 10,
        nickname: "asdf",
        profileImageUrl: "https://picsum.photos/id/237/200/300",
        detailString: '''🙋🏻‍♀️ 저는요 !
청소주기 : 이틀에 한번
음주여부 : 예
음주빈도 : 3일에 한번 
''',
        major: "소프트웨어학부",
        time: "2000-10-10 1000",
        title: "레이크홀 여자 룸메이트 구해요"));
    posts.add(Post(
        age: 10,
        nickname: "asdf",
        profileImageUrl: "https://picsum.photos/id/237/200/300",
        detailString: '''🙋🏻‍♀️ 저는요 !
청소주기 : 이틀에 한번
음주여부 : 예
음주빈도 : 3일에 한번 
''',
        major: "소프트웨어학부",
        time: "2000-10-10 1000",
        title: "레이크홀 여자 룸메이트 구해요"));
    super.onInit();
  }
}
