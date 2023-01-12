import 'package:cross_file/cross_file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/common/service/socket_service.dart';
import 'package:kuhaejwo_app/common/utils/common_storage.dart';
import 'package:kuhaejwo_app/common/http_model/GetUserResponse.dart';
import 'package:kuhaejwo_app/common/http_model/PostLoginResponse.dart';
import 'package:kuhaejwo_app/common/http_model/UserAuthInfo.dart';
import 'package:kuhaejwo_app/common/service/http_service_manager.dart';

import 'package:kuhaejwo_app/common/utils/service_response.dart';
import 'package:kuhaejwo_app/pages/auth/login/sign_in_view_page.dart';

class AuthService {
  bool get authed => CommonStorageKey.userId.read.value != null;
  Rxn<User> fbUser = Rxn(null);

  Rxn<GetUserResponse> user = Rxn(null);
  Rxn<UserBasicInfoResponse> userBasicInfo = Rxn(null);
  Rxn<UserInfoDetailResponse> userInfoDetail = Rxn(null);
  Rxn<UserPreferResponse> userPrefer = Rxn(null);
  Rxn<UserAuthInfo> userAuthInfo = Rxn(null);
  Rxn<MateOfferResponse> myMateOffer = Rxn(null);
  RxBool isUserConfirmed = false.obs;

  static final AuthService _instance = AuthService._internal();

  static AuthService get instance => Get.find<AuthService>();

  factory AuthService() => _instance;
  AuthService._internal() {
    Common.logger.d('AuthService._internal() called!!!');
  }

  Future<ServiceResponse> login(String email, String password) async {
    ServiceResponse<PostLoginResponse> loginResponse = await HttpServiceManager().postLogin(email: email, password: password);
    getFirebaseToken();
    await AuthService().getUserInfo();
    bool isUserPassRes = await checkUserConfirmed();
    CommonStorageKey.isUserPass.write(isUserPassRes);
    if (userAuthInfo.value?.id != null) {
      Get.put(SocketService());
    }

    return loginResponse;
  }

  getFirebaseToken() {
    FirebaseMessaging.instance.getToken().then((fcmToken) async {
      if (fcmToken == null) return null;
      Common.logger.d("fcm token:$fcmToken");
      // try {
      // await CommonStorageKey.userId.write(id ?? null);
      // return await Dio().post(
      //   "http://34.64.132.27:1337/api/devices",
      //   data: jsonEncode(
      //     {
      //       "data": {
      //         "FcmToken": isLogout ? "" : fcmToken,
      //         "Platform": GetPlatform.isAndroid ? "Android" : "Ios",
      //         "userId": id != null ? (GetPlatform.isAndroid ? "google-" : "apple-") + id : null,
      //         "alertSettings": alertSettings ?? 0,
      //       }
      //     },
      //   ),
      //   );
      // } catch (e) {
      // Common.logger.d(e);
    }
        // },
        );
  }

  userBasicInfoIsNeverAdded() {
    UserBasicInfoResponse? u = userBasicInfo.value;
    if (u == null) {
      return true;
    }
    return (u.age == null && u.college == null && u.department == null && u.gender == null && u.mbti == null && u.studentId == null);
  }

  setUserDetails({UserBasicInfoResponse? b, UserInfoDetailResponse? d, UserPreferResponse? p}) {
    if (b != null) {
      userBasicInfo.value = b;
    }
    if (d != null) {
      userInfoDetail.value = d;
    }
    if (p != null) {
      userPrefer.value = p;
    }
  }

  Future<bool> getUserInfo() async {
    var res = await HttpServiceManager().getUserInfo();
    if (res.result) {
      setUserDetails(b: res.value?.userBasicInfoResponse, d: res.value?.userInfoDetailResponse, p: res.value?.userPreferResponse);
      userAuthInfo.value = UserAuthInfo(
        id: res.value?.id,
        mobileNumber: res.value?.dormitory,
        name: res.value?.name,
        email: res.value?.email,
        emailAuth: res.value?.emailAuth,
        dormitory: res.value?.dormitory,
      ); //추가로 auth 관련하여 로직생성

    }
    return res.result;
  }

  //TODO:: Get user basic info 추가하기
  Future<bool> updateUserBasicInfo(Map data, bool isInit) async {
    var res = await HttpServiceManager().userBasicInfoUpdate(data: data, isInit: isInit);
    if (res.result) {
      setUserDetails(b: res.value);
    }
    return res.result;
  }

  Future<bool> getUserDetailInfo() async {
    var res = await HttpServiceManager().getUserDetailInfo();
    if (res.result) {
      setUserDetails(d: res.value);
    }
    return res.result;
  }

  Future<bool> updateUserDetailInfo(Map data, bool isInit) async {
    var res = await HttpServiceManager().userDetailInfoUpdate(data: data, isInit: isInit);
    if (res.result) {
      setUserDetails(d: res.value);
    }
    return res.result;
  }

  Future<bool> getUserPrefer() async {
    var res = await HttpServiceManager().getUserPrefer();
    if (res.result) {
      setUserDetails(p: res.value);
    }
    return res.result;
  }

  Future<bool> updateUserPrefer(Map data, bool isInit) async {
    var res = await HttpServiceManager().userPreferUpdate(data: data, isInit: isInit);
    if (res.result) {
      setUserDetails(p: res.value);
    }
    return res.result;
  }

  //MateOffer
  Future<bool> getMyMateOffer() async {
    var res = await HttpServiceManager().getMyMateOffer();
    if (res.result) {
      setMyMateOffer(m: res.value);
    }
    return res.result;
  }

  Future<bool> updateMateOffer(Map data, bool isInit) async {
    var res = await HttpServiceManager().mateOfferUpdate(data: data, isInit: isInit);
    if (res.result) {
      setMyMateOffer(m: res.value);
    }
    return res.result;
  }

  setMyMateOffer({MateOfferResponse? m}) {
    if (m != null) {
      myMateOffer.value = m;
    }
  }

  userHasMateOffer() {
    if (myMateOffer.value == null) {
      return false;
    } else {
      MateOfferResponse m = myMateOffer.value!;
      if (m.body == null) {
        return true;
      }
    }
    return false;
  }

  Future<bool> sendConfirmEmail({required String email}) async {
    ServiceResponse<String> res = await HttpServiceManager().postsendConfirmEmail(email: email);
    if (res.result) {
      // return res.value;
      return true; //성공여부 리턴
    } else {
      return false;
    }
  }

  checkUserConfirmed() async {
    ServiceResponse<bool> res = await HttpServiceManager().getIsAccountConfirmed();
    if (res.result) {
      isUserConfirmed.value = true;
      return true;
    } else {
      isUserConfirmed.value = false;
      return false;
    }
  }

  Future<bool> updateUserProfile(XFile file) async {
    // ServiceResponse<String> res = await HttpServiceManager().postUpdateUserProfile(file);
    ServiceResponse<String> res = await HttpServiceManager().getUserProfileImage();
    if (res.result) {
      //업로드 성공
      //getUserBasicInfo
      return true;
    } else {
      return false;
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    CommonStorageKey().deleteAll();
    userBasicInfo.value = null;
    userInfoDetail.value = null;
    userPrefer.value = null;
    Get.offAllNamed(SignInViewPage.url);
  }

  Future<bool> signUp({required String email, required String password, required String name}) async {
    ServiceResponse res = await HttpServiceManager().postSignUp(email: email, password: password, name: name).load();
    if (res.result) {
      return true;
    } else {
      Get.dialog(Common.commonModal(mainText: res.errorMsg, numberOfButton: 1));
      return false;
    }
  }

//   Future<dynamic> registerDevice({String? id, int? alertSettings, bool isLogout = false}) async {
//     id ??= CommonStorageKey.userId.read.value;
//     if (id == null) {
//       return;
//     }

//     alertSettings ??= int.tryParse(CommonStorageKey.userAlertSettings.read.value ?? '');
//     // if (alertSettings != null) {
//     //   alertSettings += 1;
//     // }

//     FirebaseMessaging.instance.getToken().then(
//       (fcmToken) async {
//         if (fcmToken == null) return null;
//         Common.logger.d("fcm token:" + (fcmToken));
//         try {
//           CommonStorageKey.userId.write(id!);
//           return await Dio().post(
//             "/api/devices".getUrl,
//             data: jsonEncode(
//               {
//                 "data": {
//                   "FcmToken": isLogout ? "" : fcmToken,
//                   "Platform": GetPlatform.isAndroid ? "Android" : "Ios",
//                   "userId": (GetPlatform.isAndroid ? "google-" : "apple-") + id,
//                   "alertSettings": alertSettings ?? 0,
//                 }
//               },
//             ),
//           );
//         } catch (e) {
//           Common.logger.d(e);
//         }
//       },
//     );
//   }
}
