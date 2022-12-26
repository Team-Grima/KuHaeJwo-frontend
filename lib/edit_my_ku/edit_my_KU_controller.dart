import 'package:get/get.dart';
import 'package:pet_app/common/model/user_model.dart';
import 'package:pet_app/survey_page/survey_view_page.dart';

class EditMyKUController extends GetxController {
  List<String> college = [
    "문과대학",
    "이과대학",
    "건축대학",
    "공과대학",
    "사회과학대학",
    "경영대학",
    "부동산과학원",
    "KU융합과학기술원",
    "상허생명과학대학",
    "수의과대학",
    "예술디자인대학",
    "사범대학",
  ];

  Map<String, List<String>> department = {
    "문과대학": ["국어국문학과", "영어영문학과", "중어중문학과", "철학과", "사학과", "지리학과", "미디어커뮤니케이션학과", "문화콘텐츠학과"],
    "이과대학": ["수학과", "물리학과", "화학과"],
    "건축대학": ["건축학부"],
    "공과대학": ["사회환경공학부", "기계항공공학부", "전기전자공학부", "화학공학부", "컴퓨터공학부", "산업공학과", "신산업융합학과", "생물공학과", "K뷰티산업융합학과"],
    "사회과학대학": ["정치외교학과", "경제학과", "행정학과", "국제무역학과", "응용통계학과", "융합인재학과", "글로벌비즈니스학과"],
    "경영대학": ["경영학과", "기술경영학과"],
    "부동산과학원": ["부동산학과"],
    "KU융합과학기술원": ["미래에너지공학과", "스마트운행체공학과", "스마트ICT융합공학과", "화장품공학과", "줄기세포재생공학과", "의생명공학과", "시스템생명공학과", "융합생명공학과"],
    "상허생명과학대학": ["생명과학특성학과", "동물자원과학과", "식량자원과학과", "축산식품생명공학과", "식품유통공학과", "환경보건과학과", "산림조경학과"],
    "수의과대학": ["수의예과"],
    "예술디자인대학": ["커뮤니케이션디자인학과", "산업디자인학과", "의상디자인학과", "리빙디자인학과", "현대미술학과", "영상영화학과"],
    "사범대학": ["일어교육과", "수학교육과", "체육교육과", "음악교육과", "교육공학과", "영어교육과"]
  };
  List<String> age = [
    "19살",
    "20살",
    "21살",
    "22살",
    "23살",
    "24살",
    "25살",
    "26살",
    "27살",
    "28살",
    "29살",
    "30살",
    "30~",
  ];
  List<String> hak = [
    "23학번",
    "22학번",
    "21학번",
    "20학번",
    "19학번",
    "그 이상",
  ];

  List<String> MBTI = [
    "INFP",
    "ENFP",
    "INFJ",
    "ENFJ",
    "INTJ",
    "ENTJ",
    "INTP",
    "ENTP",
    "ISFP",
    "ESFP",
    "ISTP",
    "ESTP",
    "ISFJ",
    "ESFJ",
    "ISTJ",
    "ESTJ",
    "비공개",
  ];
  List<String> gender = [
    "남자",
    "여자",
  ];

  List<String> hintList = [
    "소속 단과 대학을 선택해주세요",
    "소속 학과를 선택해주세요",
    "학번을 선택해주세요",
    "나이를 선택해주세요",
    "MBTI를 선택해주세요",
    "성별",
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
      "성별": RxnInt(null),
    };
    super.onInit();
  }

  routeToSurvey() {
    Get.toNamed(SurveyViewPage.url);
  }

  void submit() {
    saveSettings();
    routeToSurvey();
  }

  saveSettings() async {
    // HttpServiceManager().saveUserInfo();
  }
}
