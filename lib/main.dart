import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_app/common/service/auth_service.dart';
import 'package:pet_app/firebase_options.dart';

import 'package:get_storage/get_storage.dart';
import 'package:pet_app/pages/splash/splash_page.dart';

import 'route/routes.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  WidgetsFlutterBinding.ensureInitialized(); //main에서 비동기 메소드 사용할때 사용

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // 화면 회전 방지 설정
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //플펫폼 강제로 UI 요소를 비활성화 시켜야할때 사용되는 메소드
    statusBarColor: Colors.transparent, //Statusbar 색상을 투명으로 바꿔줌
  ));
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  await GetStorage.init();
  Get.put(AuthService());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScreenUtilInit(
    //화면 일정 비율로 설정해주기 위한 클래스
    designSize: const Size(375, 812),
    minTextAdapt: true, //너비와 높이의 최소값에 따라 텍스트를 조정할지 여부
    builder: (context, child) => GetMaterialApp(
        defaultTransition: Transition.cupertino,
        builder: (context, child) {
          return MediaQuery(
            //화면마다 각각 다르게 css를 주는 함수
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!, // child는 null이 아님을 해서 에러 방지 해둠.
          );
        },
        theme: ThemeData(fontFamily: 'NotoSansKR'), //전체 테마 폰트를 설정해뒀음. 변경하고 싶으면 Theme.of().textTheme 사용하면 됨
        debugShowCheckedModeBanner: false, //Debug 모양 나오는거 없애기
        locale: Get.deviceLocale, //현재 표시할 언어(디바이스) 설정
        home: const SplashPage(), //home을 실행할때 로딩창으로 띄움
        getPages: GetXRouter.route), // route에 있는 경로들을 get에 넣어준다
  ));
}
