import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/service/auth_service.dart';

class MateOfferController extends GetxController {
  AuthService authService = AuthService();
  @override
  void onReady() {
    authService.getUserPrefer().load();
    fetchMateOfferData();
  }

  fetchMateOfferData() async {
    bool res = await authService.getMyMateOffer().load();
    if (res && authService.myMateOffer.value != null) {
      // } else {
      //신규작성
      // }
    }
  }
  // submit() async {
  //   if (isPass.value) {
  //     var res = await .load();
  //     if (res) {
  //       Get.back();
  //     } else {
  //       Common.showSnackbar(message: "오류가 발생했습니다");
  //     }
  //     Get.back();
  //   }
  //   // if(selectedPrefer)
  // }
}
