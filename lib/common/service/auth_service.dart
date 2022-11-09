import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/common_storage.dart';

class AuthService {
  bool get authed => CommonStorageKey.userId.read.value != null;
  // Rxn<UserModel> user = Rxn(null);
  // Rxn<StoreModel> store = Rxn(null);

  static final AuthService _instance = AuthService._internal();

  static AuthService get instance => Get.find<AuthService>();

  factory AuthService() => _instance;
  AuthService._internal() {
    Common.logger.d('AreaService._internal() called!!!');
  }
  login() {
    return;
  }

  bool isSubscribed() {
    return !false;
  }

  logout() {}

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
