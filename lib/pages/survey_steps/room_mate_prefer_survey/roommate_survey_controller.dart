import 'package:get/get.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/service/auth_service.dart';

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
  @override
  onReady() {
    fetchData();
  }

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

  submit() async {
    if (isPass.value) {
      var res = await authService.updateUserPrefer({"preferList": selectedPrefer.toList()}, authService.userPrefer.value == null).load();
      if (res) {
        Get.back();
      } else {
        Common.showSnackbar(message: "오류가 발생했습니다");
      }
      Get.back();
    }
    // if(selectedPrefer)
  }

  fetchData() async {
    bool res = await authService.getUserPrefer().load();
    if (res && authService.userPrefer.value != null) {
      for (String s in authService.userPrefer.value?.preferList ?? []) {
        addSelectedPrefer(s);
      }

      // } else {
      //신규작성
      // }
    }
  }
}
