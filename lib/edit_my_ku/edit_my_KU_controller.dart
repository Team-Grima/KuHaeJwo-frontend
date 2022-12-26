import 'package:get/get.dart';
import 'package:pet_app/common/model/user_model.dart';
import 'package:pet_app/survey_page/survey_view_page.dart';

class EditMyKUController extends GetxController {
  Map<String, List<String>> dropDownListMap = {
    "소속 단과 대학": [
      "공과대학",
      "문과대학",
    ],
    "소속 학과": [
      "컴퓨터공학부",
      "전기전자공학부",
      "화학공학부",
    ],
    "학번": [
      "23",
      "22",
      "21",
      "20",
      "19",
      "18",
      "17",
      "16",
      "15",
      "14",
      "~13",
    ],
    "나이": [
      "19",
      "20",
      "21",
      "22",
      "23",
      "24",
      "25",
      "26",
      "27",
      "28",
      "29",
      "30",
      "30~",
    ],
    "MBTI": [
      "ISFP",
      "ISFP",
      "ISFP",
      "ISFP",
      "ISFP",
      "ISFP",
    ],
  };
  List<String> hintList = [
    "소속 단과 대학을 선택해주세요",
    "소속 학과를 선택해주세요",
    "학번을 선택해주세요",
    "나이를 선택해주세요",
    "MBTI를 선택해주세요",
  ];
  Map<String, RxnInt> selectedIndexMap = <String, RxnInt>{}.obs;
  Rxn<UserModel> user = Rxn(null);
  @override
  void onInit() {
    selectedIndexMap = {
      "소속 단과 대학": RxnInt(null),
      "소속 학과": RxnInt(null),
      "학번": RxnInt(null),
      "나이": RxnInt(null),
      "MBTI": RxnInt(null),
    };
    super.onInit();
  }

  routeToSurvey() {
    Get.toNamed(SurveyViewPage.url);
  }
}
