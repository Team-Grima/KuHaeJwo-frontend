import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/common_storage.dart';
import 'package:pet_app/common/http_model/GetUserResponse.dart';
import 'package:pet_app/common/http_model/PostLoginResponse.dart';
import 'package:pet_app/common/http_model/UserAuthInfo.dart';
import 'package:pet_app/common/service/http_service_manager.dart';

import 'package:pet_app/common/service_response.dart';
import 'package:pet_app/pages/auth/login/sign_in_view_page.dart';

class AuthService {
  bool get authed => CommonStorageKey.userId.read.value != null;
  Rxn<User> fbUser = Rxn(null);

  Rxn<GetUserResponse> user = Rxn(null);
  Rxn<UserBasicInfoResponse> userBasicInfo = Rxn(null);
  Rxn<UserInfoDetailResponse> userInfoDetail = Rxn(null);
  Rxn<UserPreferResponse> userPrefer = Rxn(null);
  Rxn<UserAuthInfo> userAuthInfo = Rxn(null);

  static final AuthService _instance = AuthService._internal();

  static AuthService get instance => Get.find<AuthService>();

  factory AuthService() => _instance;
  AuthService._internal() {
    Common.logger.d('AuthService._internal() called!!!');
  }

  Future<ServiceResponse> login(String email, String password) async {
    ServiceResponse<PostLoginResponse> loginResponse = await HttpServiceManager().postLogin(email: email, password: password);
    return loginResponse;
    // UserCredential userCredential;
    // try {
    //   userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    //   fbUser.value = userCredential.user;
    // } catch (e) {
    //   userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    //   fbUser.value = userCredential.user;
    // }
    // createFirestoreUser(userCredential);
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
    }
    return res.result;
  }

  //TODO:: Get user basic info
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

// register(){
//   FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
// }
  void createFirestoreUser(UserCredential userCredential) async {
    if (userCredential.user != null) {
      return await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: userCredential.user!.email,
          id: userCredential.user!.uid, // UID from Firebase Authentication
          imageUrl: 'https://i.pravatar.cc/300',
        ),
      );
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
