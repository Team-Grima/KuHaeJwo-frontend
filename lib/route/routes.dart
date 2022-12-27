import 'package:pet_app/alarm/alarm_view_page.dart';
import 'package:pet_app/auth/login/sign_in_view_page.dart';
import 'package:pet_app/auth/password_change/change_password_view_page.dart';
import 'package:pet_app/chat/chat_room_list/chat_room_list_view_page.dart';
import 'package:pet_app/common/http_model/GetMateOfferListResponse.dart';

import 'package:pet_app/main_view_page/main_view_page.dart';
import 'package:pet_app/home/home_view_page.dart';
import 'package:pet_app/user_post_view_page/user_post_view_page.dart';
import 'package:pet_app/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:pet_app/survey_steps/survey_step_0/survey_step_0_view_page.dart';

class GetXRouter {
  static final route = [
    // GetPage(name: MoreHelp.url, page: () => const MoreHelp()),
    GetPage(name: SplashPage.url, page: () => const SplashPage()),
    GetPage(name: SignInViewPage.url, page: () => const SignInViewPage()),

    GetPage(name: HomeViewPage.url, page: () => const HomeViewPage()),
    GetPage(name: MainPage.url, page: () => const MainPage()),
    GetPage(name: UserPostViewPage.url, page: () => const UserPostViewPage()),
    GetPage(name: AlarmViewPage.url, page: () => const AlarmViewPage()),
    GetPage(name: SurveyViewPage.url, page: () => const SurveyViewPage()),
    // GetPage(name: SurveyStep1ViewPage.url, page: () => const SurveyStep1ViewPage()),
    GetPage(name: ChangePWViewPage.url, page: () => const ChangePWViewPage()),
    GetPage(name: ChatRoomListViewPage.url, page: () => const ChatRoomListViewPage()),
    //survey
    // GetPage(name: RoomMateSurveyViewPage.url, page: () => const RoomMateSurveyViewPage()),
    // GetPage(name: ChatRoomViewPage.url, page: () => ChatRoomViewPage(room: )),
    // GetPage(name: ChatPage.url, page: () => const ChatPage()),
    // GetPage(name: AddPostPage.url, page: () => const AddPostPage()),
    // GetPage(name: MyPageViewPage.url, page: () => const MyPageViewPage()),
    // GetPage(name: SettingViewPage.url, page: () => const SettingViewPage()),

    // GetPage(name: EditMyKUViewPage.url, page: () => EditMyKUViewPage()),
  ];
}

class UserDetailDataRouteParams {
  UserDetailData userDetailData;

  UserDetailDataRouteParams({required this.userDetailData});
}
