import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/http_model/GetUserResponse.dart';
import 'package:pet_app/common/service/auth_service.dart';
import 'package:pet_app/common/service_response.dart';

import '../../common/service/http_service_manager.dart';

class RoomMateSurveyController extends GetxController {
  AuthService authService = AuthService();
  List<String> preferList = [
    "청소(정리정돈)를 자주하는",
    "청소(정리정돈)를 몰아서 하는",
    "술을 멀리하는",
    "담배를 안피는",
    "취침시간이 비슷한",
    "기상시간이 비슷한",
    "잠버릇이 없는",
    "예민하지 않은",
    "추위를 많이타는",
    "더위를 많이타는",
    "정이 많은",
  ];
  RxList<String> selectedPrefer = <String>[].obs;
  RxBool isPass = false.obs;
  addSelectedPrefer(String item) {
    if (isSelectedPrefer(item)) {
      selectedPrefer.remove(item);
      verify();
      return;
    }
    if (selectedPrefer.length < 3) {
      selectedPrefer.add(item);
    } else {
      Common.showSnackbar(message: "최대 3개까지 고를 수 있어요! ");
    }
    verify();
  }

  isSelectedPrefer(String item) {
    return selectedPrefer.contains(item);
  }

  verify() {
    if (selectedPrefer.length == 3) {
      isPass.value = true;
    } else {
      isPass.value = false;
    }
  }

  submit() {
    if (isPass.value) {
      // var res = HttpServiceManager().updateUserPrefer({"data": selectedPrefer.toString()});
      // authService.userPreferData.value = res.data;

      Get.back();
    }
    // if(selectedPrefer)
  }

  fetchData() async {
    ServiceResponse<GetUserResponse> res = await HttpServiceManager().getUserInfo();
    // if (res.result && res.value?.userPreferData != null) {
    // authService.userPreferData.value = res.value!.userPreferData;
    for (String s in authService.userPreferData.value?.preferDataList ?? []) {
      addSelectedPrefer(s);
    }

    // } else {
    //신규작성
    // }
  }
}
