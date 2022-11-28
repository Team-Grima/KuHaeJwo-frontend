import 'package:pet_app/alarm/alarm_view_page.dart';
import 'package:pet_app/edit_my_ku/edit_my_KU_view_page.dart';
import 'package:pet_app/main_view_page/main_view_page.dart';
import 'package:pet_app/home/home_view_page.dart';
import 'package:pet_app/post_detail_view_page/post_detail_view_page.dart';
import 'package:pet_app/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:pet_app/survey_page/survey_view_page.dart';

class GetXRouter {
  static final route = [
    // GetPage(name: MoreHelp.url, page: () => const MoreHelp()),
    GetPage(name: SplashPage.url, page: () => const SplashPage()),
    GetPage(name: HomeViewPage.url, page: () => const HomeViewPage()),
    GetPage(name: MainPage.url, page: () => const MainPage()),
    GetPage(name: PostDetailViewPage.url, page: () => const PostDetailViewPage()),
    GetPage(name: AlarmViewPage.url, page: () => const AlarmViewPage()),
    GetPage(name: EditMyKUViewPage.url, page: () => const EditMyKUViewPage()),
    GetPage(name: SurveyViewPage.url, page: () => const SurveyViewPage()),
    // GetPage(name: ChatPage.url, page: () => const ChatPage()),
    // GetPage(name: AddPostPage.url, page: () => const AddPostPage()),
    // GetPage(name: MyPageViewPage.url, page: () => const MyPageViewPage()),
    // GetPage(name: SettingViewPage.url, page: () => const SettingViewPage()),
  ];
}

class PostDetailRouteParams {
  Post post;

  PostDetailRouteParams({required this.post});
}
