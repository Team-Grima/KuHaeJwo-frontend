import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/common_storage.dart';
import 'package:pet_app/common/http_model/PostLoginResponse.dart';
import 'package:pet_app/common/model/user_model.dart';
import 'package:pet_app/common/service/http_service_manager.dart';
import 'package:pet_app/common/service/service_response.dart';

class AuthService {
  bool get authed => CommonStorageKey.userId.read.value != null;
  Rxn<UserModel> user = Rxn(null);
  // Rxn<StoreModel> store = Rxn(null);
  Rxn<User> fbUser = Rxn(null);

  static final AuthService _instance = AuthService._internal();

  static AuthService get instance => Get.find<AuthService>();

  factory AuthService() => _instance;
  AuthService._internal() {
    Common.logger.d('AreaService._internal() called!!!');
  }

// register(){
//   FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
// }
  login(String email, String password) async {
    // user.value = (await HttpServiceManager.postLogin(email, password)).value;
    ServiceResponse<PostLoginResponse> loginResponse = await HttpServiceManager().postLogin(email: email, password: password);
    if (loginResponse.result) {
      //로그인 성공

      Common.showSnackbar(message: loginResponse.value!.data!.accessToken!);
    } else {
      Common.showSnackbar(message: loginResponse.errorMsg);
    }
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      fbUser.value = userCredential.user;
    } catch (e) {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      fbUser.value = userCredential.user;
    }
    createFirestoreUser(userCredential);
  }

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
//             "http://34.64.132.27:1337/api/devices",
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
