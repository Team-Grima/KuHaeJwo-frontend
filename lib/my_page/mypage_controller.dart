import 'package:get/get.dart';
import 'package:pet_app/common/model/user_model.dart';
import 'package:pet_app/common/service/auth_service.dart';

class MyPageController extends GetxController {
  Rxn<UserModel> user = Rxn(null);
  AuthService authService = AuthService();
}
