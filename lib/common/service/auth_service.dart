import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/common_storage.dart';
import 'package:pet_app/common/model/user_model.dart';

class AuthService {
  bool get authed => CommonStorageKey.userId.read.value != null;
  Rxn<UserModel> user = Rxn(null);
  // Rxn<StoreModel> store = Rxn(null);

  static final AuthService _instance = AuthService._internal();

  static AuthService get instance => Get.find<AuthService>();

  factory AuthService() => _instance;
  AuthService._internal() {
    Common.logger.d('AreaService._internal() called!!!');
  }
  login(String email, String password) async {
    // user.value = (await HttpServiceManager.postLogin(email, password)).value;
    user.value = UserModel(username: "username", major: "소프트웨어학과", age: 12, upperMajor: "공과대학", profileImageUrl: "https://picsum.photos/200/300");
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
