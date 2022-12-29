import 'package:get/get.dart';
import 'package:pet_app/common/enum/survey_enums.dart';

class SurveyController extends GetxController {
  List<SurveyInfo> surveyList = [
    SurveyInfo(
      question: "나의 청소 습관은?",
      icon: "🧹",
      index: 0,
      enumList: CleanHabit.values,
      ansMap: {
        CleanHabit.LAZY: "몰아서치워요",
        CleanHabit.EAGER: "바로바로 치워요",
      },
    ),
    SurveyInfo(
      question: "나의 씻는 시간은?",
      icon: "🛁",
      index: 1,
      enumList: WashingTime.values,
      ansMap: {
        WashingTime.WAKE_UP: "보통은 일어나서",
        WashingTime.BEFORE_SLEEP: "보통은 자기전에",
        WashingTime.BOTH: "아침 저녁 으로다가 깨끗히",
      },
    ),
    SurveyInfo(
      question: "나의 음주 여부는?",
      icon: "🍻",
      index: 2,
      enumList: Alcohol.values,
      ansMap: {
        Alcohol.OFTEN: "자주 마신다",
        Alcohol.YES: "가끔 마신다",
        Alcohol.NO: "안마신다",
      },
    ),
    SurveyInfo(
      question: "나의 흡연 여부는?",
      icon: "🚬",
      index: 3,
      enumList: Smoking.values,
      ansMap: {
        Smoking.YES: "흡연자",
        Smoking.NO: "비흡연자",
      },
    ),
    SurveyInfo(
      question: "나의 취침시간은?",
      icon: "🌙",
      index: 4,
      enumList: SleepingTime.values,
      ansMap: {
        SleepingTime.BEFORE_12PM: "밤 12시 이전",
        SleepingTime.AFTER_12PM: "밤 12시 이후",
        SleepingTime.MORNING: "해 뜨고 나서",
      },
    ),
    SurveyInfo(
      question: "나의 잠버릇은?",
      icon: "😪",
      index: 5,
      enumList: SleepingHabit.values,
      ansMap: {},
    ),
    SurveyInfo(
      question: "나의 잠귀는?",
      icon: "👂🏻",
      index: 6,
      enumList: Sleeper.values,
      ansMap: {},
    ),
    SurveyInfo(
      question: "나의 기상시간은?",
      icon: "🌞",
      index: 7,
      enumList: WakeUpTime.values,
      ansMap: {},
    ),
    SurveyInfo(
      question: "나는 알람을?",
      icon: "⏰",
      index: 8,
      enumList: Alarm.values,
      ansMap: {},
    ),
    SurveyInfo(
      question: "나는 밖에 있는 시간이?",
      icon: "🤡",
      index: 9,
      enumList: Outing.values,
      ansMap: {},
    ),
    SurveyInfo(
      question: "나는 벌레를?",
      icon: "🪳",
      index: 10,
      enumList: Bug.values,
      ansMap: {},
    ),
    SurveyInfo(
      question: "나의 온도는?",
      icon: "🌡️",
      index: 11,
      enumList: Temperature.values,
      ansMap: {},
    ),
    SurveyInfo(
      question: "나는 룸메와?",
      icon: "🤝🏻",
      index: 12,
      enumList: Friend.values,
      ansMap: {},
    ),
  ];
  RxInt currentStep = (0).obs;
  late int maxStep;
  @override
  void onInit() {
    super.onInit();
    maxStep = surveyList.length;
  }

  nextStep() {
    if (currentStep.value < maxStep - 1) {
      currentStep.value++;
    } else {
      //저장하기
    }
  }

  prevStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    } else {
      //저장하기
    }
  }

  saveConfigs() {
    // HttpServiceManager().saveUserDetailConfigs();
    Get.back();
  }

  SurveyInfo getCurrent() {
    return surveyList[currentStep.value];
  }

  selectSurveyItem(SurveyInfo current, item) {
    current.userSelect = item;
    update();
  }
}

class SurveyInfo<T> {
  String question;
  T? userSelect;
  String icon;
  int index;
  List<T> enumList;
  Map<T, String> ansMap;
  SurveyInfo({required this.question, this.userSelect, required this.icon, required this.index, required this.enumList, required this.ansMap});
}
