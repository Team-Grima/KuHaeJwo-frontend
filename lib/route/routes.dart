import 'package:pet_app/defaultPages/main_view_page/main_view_page.dart';
import 'package:pet_app/home/home_view_page.dart';
import 'package:pet_app/splash/splash_page.dart';
import 'package:get/get.dart';

class GetXRouter {
  static final route = [
    // GetPage(name: MoreHelp.url, page: () => const MoreHelp()),
    GetPage(name: SplashPage.url, page: () => const SplashPage()),
    GetPage(name: HomeViewPage.url, page: () => const HomeViewPage()),
    GetPage(name: MainPage.url, page: () => const MainPage()),
    // GetPage(name: ChatPage.url, page: () => const ChatPage()),
    // GetPage(name: AddPostPage.url, page: () => const AddPostPage()),
    // GetPage(name: MyPageViewPage.url, page: () => const MyPageViewPage()),
    // GetPage(name: SettingViewPage.url, page: () => const SettingViewPage()),
  ];
}
