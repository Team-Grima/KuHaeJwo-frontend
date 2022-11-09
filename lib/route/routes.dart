import 'package:pet_app/splash/splash_page.dart';
import 'package:get/get.dart';

class GetXRouter {
  static final route = [
    // GetPage(name: MoreHelp.url, page: () => const MoreHelp()),
    GetPage(name: SplashPage.url, page: () => const SplashPage()),
    // GetPage(name: OnlineViewPage2.url, page: () => OnlineViewPage2()),
  ];
}
