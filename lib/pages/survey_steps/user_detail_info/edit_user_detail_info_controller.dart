import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/common/enum/survey_enums.dart';
import 'package:kuhaejwo_app/common/service/auth_service.dart';

class EditUserDetailController extends GetxController {
  AuthService authService = AuthService();
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
      ansMap: {
        SleepingHabit.BRUXISM: "이갈이",
        SleepingHabit.SNORE: "코골이",
        SleepingHabit.NO: "거의 없음",
      },
    ),
    SurveyInfo(
      question: "나의 잠귀는?",
      icon: "👂🏻",
      index: 6,
      enumList: Sleeper.values,
      ansMap: {
        Sleeper.LIGHT: "많이 예민한 편",
        Sleeper.HEAVY: "누가 업어가도 모름",
      },
    ),
    SurveyInfo(
      question: "나의 기상시간은?",
      icon: "🌞",
      index: 7,
      enumList: WakeUpTime.values,
      ansMap: {
        WakeUpTime.AFTER_PM: "오후",
        WakeUpTime.AROUND_AM12: "낮 12 전후",
        WakeUpTime.BEFORE_AM09: "오전 9시 이전",
      },
    ),
    SurveyInfo(
      question: "나는 알람을?",
      icon: "⏰",
      index: 8,
      enumList: Alarm.values,
      ansMap: {
        Alarm.NO: "잘 듣고 일어나는 편",
        Alarm.YES: "잘 못듣는 편",
      },
    ),
    SurveyInfo(
      question: "나는 밖에 있는 시간이?",
      icon: "🤡",
      index: 9,
      enumList: Outing.values,
      ansMap: {
        Outing.LESS: "나는 집이좋아..",
        Outing.MORE: "완전 대문자 E! 밖이 좋아요",
      },
    ),
    SurveyInfo(
      question: "나는 벌레를?",
      icon: "🪳",
      index: 10,
      enumList: Bug.values,
      ansMap: {
        Bug.NO: "무서워한다(못잡음).",
        Bug.YES: "잡을 수 있다.",
      },
    ),
    SurveyInfo(
      question: "나의 온도는?",
      icon: "🌡️",
      index: 11,
      enumList: Temperature.values,
      ansMap: {
        Temperature.COLD: "추위를 많이 탄다.",
        Temperature.HEAT: "더위를 많이 탄다.",
        Temperature.NO: "노상관",
      },
    ),
    SurveyInfo(
      question: "나는 룸메와?",
      icon: "🤝🏻",
      index: 12,
      enumList: Friend.values,
      ansMap: {
        Friend.BEST_FRIEND: "베프가 되고 싶다.",
        Friend.FRIEND_WITH_BENEFIT: "공간공유(진지)",
      },
    ),
  ];
  RxInt currentStep = (0).obs;
  late int maxStep;
  late ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    maxStep = surveyList.length;
  }

  @override
  onReady() {
    fetchData();
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

  saveConfigs() async {
    // HttpServiceManager().saveUserDetailConfigs();

    var res = await authService.updateUserDetailInfo({
      "cleanHabit": surveyList[0].getSelectedValue(),
      "washingTime": surveyList[1].getSelectedValue(),
      "alcohol": surveyList[2].getSelectedValue(),
      "smoking": surveyList[3].getSelectedValue(),
      "sleepingTime": surveyList[4].getSelectedValue(),
      "sleepingHabit": surveyList[5].getSelectedValue(),
      "sleeper": surveyList[6].getSelectedValue(),
      "wakeUpTime": surveyList[7].getSelectedValue(),
      "alarm": surveyList[8].getSelectedValue(),
      "outing": surveyList[9].getSelectedValue(),
      "bug": surveyList[10].getSelectedValue(),
      "temperature": surveyList[11].getSelectedValue(),
      "friend": surveyList[12].getSelectedValue(),
    }, authService.userInfoDetail.value == null).load();
    if (res) {
      Get.back();
    } else {
      Common.showSnackbar(message: "오류가 발생했습니다");
    }
  }

  fetchData() async {
    bool res = await authService.getUserDetailInfo().load();
    if (res && authService.userInfoDetail.value != null) {
      surveyList[0].setSelectValue(authService.userInfoDetail.value!.cleanHabit);
      surveyList[1].setSelectValue(authService.userInfoDetail.value!.washingTime);
      surveyList[2].setSelectValue(authService.userInfoDetail.value!.alcohol);
      surveyList[3].setSelectValue(authService.userInfoDetail.value!.smoking);
      surveyList[4].setSelectValue(authService.userInfoDetail.value!.sleepingTime);
      surveyList[5].setSelectValue(authService.userInfoDetail.value!.sleepingHabit);
      surveyList[6].setSelectValue(authService.userInfoDetail.value!.sleeper);
      surveyList[7].setSelectValue(authService.userInfoDetail.value!.wakeUpTime);
      surveyList[8].setSelectValue(authService.userInfoDetail.value!.alarm);
      surveyList[9].setSelectValue(authService.userInfoDetail.value!.outing);
      surveyList[10].setSelectValue(authService.userInfoDetail.value!.bug);
      surveyList[11].setSelectValue(authService.userInfoDetail.value!.temperature);
      surveyList[12].setSelectValue(authService.userInfoDetail.value!.friend);
      update();
    } else {
      //신규작성
    }
  }

  SurveyInfo getCurrent() {
    return surveyList[currentStep.value];
  }

  selectSurveyItem(SurveyInfo current, item) {
    current.userSelect == item ? current.userSelect = null : current.userSelect = item;
    scrollController.animateTo(scrollController.position.pixels + 90.r, duration: const Duration(milliseconds: 500), curve: Curves.ease);
    print(scrollController.position.pixels);

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
  getSelectedValue() {
    if (userSelect == null) {
      return null;
    } else {
      return userSelect.toString().split(".")[1];
    }
  }

  setSelectValue(String? sel) {
    if (sel != null) {
      for (var i in enumList) {
        if (sel == i.toString().split(".")[1]) {
          userSelect = i;
          return;
        }
      }

      userSelect = null;
      return;
    } else {
      userSelect = null;
      return;
    }
  }

  SurveyInfo({required this.question, this.userSelect, required this.icon, required this.index, required this.enumList, required this.ansMap});
}
