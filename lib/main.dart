import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/common/service/auth_service.dart';

import 'package:kuhaejwo_app/pages/splash/splash_page.dart';

import 'route/routes.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Common.logger.d('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel, channel1, channel2, channel3, channel4, channel5, channel6, channel7, channel8;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  WidgetsFlutterBinding.ensureInitialized(); //main에서 비동기 메소드 사용할때 사용

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // 화면 회전 방지 설정
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //플펫폼 강제로 UI 요소를 비활성화 시켜야할때 사용되는 메소드
    statusBarColor: Colors.transparent, //Statusbar 색상을 투명으로 바꿔줌
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'alert_channel0', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  var initialzationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

  var initialzationSettingsIOS = const DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  var initializationSettings = InitializationSettings(android: initialzationSettingsAndroid, iOS: initialzationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessageOpenedApp.listen(
    (event) {
      Common.logger.d(event);
      if (event.notification != null) {
        Common.showSnackbar(message: '지진이 발생하였습니다');
        Get.toNamed('/eq-show');
      }
    },
  );

  FirebaseMessaging.onMessage.listen(
    (event) {
      Common.logger.d(event);
      if (event.notification != null) {
        Common.showSnackbar(message: '지진이 발생하였습니다');
        Get.toNamed('/eq-show');
      }
    },
  );

  Get.put(AuthService());

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
