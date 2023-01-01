import 'package:pet_app/pages/alarm/alarm_view_page.dart';
import 'package:pet_app/pages/auth/find_password/find_password_view_page.dart';
import 'package:pet_app/pages/auth/login/sign_in_view_page.dart';
import 'package:pet_app/pages/auth/password_change/change_password_view_page.dart';
import 'package:pet_app/pages/auth/register/register_view_page.dart';
import 'package:pet_app/pages/chat/chat_room_list/chat_room_list_view_page.dart';
import 'package:pet_app/common/http_model/GetUserResponse.dart';

import 'package:pet_app/pages/main_view_page/main_view_page.dart';
import 'package:pet_app/pages/home/home_view_page.dart';
import 'package:pet_app/pages/mate_offer/mate_offer_create/mate_offer_view_page.dart';
import 'package:pet_app/pages/mate_offer/mate_offer_edit/mate_offer_edit_view_page.dart';
import 'package:pet_app/pages/splash/splash_page.dart';
import 'package:pet_app/pages/user_post_view_page/user_post_view_page.dart';
import 'package:get/get.dart';
import 'package:pet_app/pages/survey_steps/user_detail_info/survey_step_0_view_page.dart';

import '../pages/auth/certificate_auth/certificate_auth_view_page.dart';
import '../pages/auth/email_auth/email_auth_view_page.dart';
import '../pages/auth/school_auth/school_auth_view_page.dart';

class GetXRouter {
  static final route = [
    // GetPage(name: MoreHelp.url, page: () => const MoreHelp()),
    //splash
    GetPage(name: SplashPage.url, page: () => const SplashPage()),

    //AUTH
    GetPage(name: SignInViewPage.url, page: () => const SignInViewPage()),
    GetPage(name: RegisterViewPage.url, page: () => const RegisterViewPage()),
    GetPage(name: FindPasswordViewPage.url, page: () => const FindPasswordViewPage()),
    GetPage(name: ChangePWViewPage.url, page: () => const ChangePWViewPage()),
    GetPage(name: SchoolAuthViewPage.url, page: () => const SchoolAuthViewPage()),
    GetPage(name: CertificateAuthViewPage.url, page: () => const CertificateAuthViewPage()),
    GetPage(name: EmailAuthViewPage.url, page: () => const EmailAuthViewPage()),

    //user
    GetPage(name: HomeViewPage.url, page: () => const HomeViewPage()),
    GetPage(name: MainPage.url, page: () => const MainPage()),
    GetPage(name: UserPostViewPage.url, page: () => const UserPostViewPage()),
    GetPage(name: AlarmViewPage.url, page: () => const AlarmViewPage()),
    GetPage(name: SurveyViewPage.url, page: () => const SurveyViewPage()),
    // GetPage(name: SurveyStep1ViewPage.url, page: () => const SurveyStep1ViewPage()),
    //CHAT
    GetPage(name: ChatRoomListViewPage.url, page: () => const ChatRoomListViewPage()),
    //survey

    //MATE_OFFER
    GetPage(name: MateOfferViewPage.url, page: () => const MateOfferViewPage()),
    GetPage(name: MateOfferEditViewPage.url, page: () => const MateOfferEditViewPage()),

    // GetPage(name: RoomMateSurveyViewPage.url, page: () => const RoomMateSurveyViewPage()),
    // GetPage(name: ChatRoomViewPage.url, page: () => ChatRoomViewPage(room: )),
    // GetPage(name: ChatPage.url, page: () => const ChatPage()),
    // GetPage(name: AddPostPage.url, page: () => const AddPostPage()),
    // GetPage(name: MyPageViewPage.url, page: () => const MyPageViewPage()),
    // GetPage(name: SettingViewPage.url, page: () => const SettingViewPage()),

    // GetPage(name: EditMyKUViewPage.url, page: () => EditMyKUViewPage()),
  ];
}

class UserInfoDetailDataRouteParams {
  UserInfoDetailResponse userInfoDetail;

  UserInfoDetailDataRouteParams({required this.userInfoDetail});
}

class MateOfferUserParams {
  MateOfferResponse mateOffer;

  MateOfferUserParams({required this.mateOffer});
}
