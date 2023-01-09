import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/common/service/socket_service.dart';
import 'package:kuhaejwo_app/common/utils/common_storage.dart';
import 'package:kuhaejwo_app/common/service/auth_service.dart';
import 'package:kuhaejwo_app/pages/auth/login/sign_in_view_page.dart';
import 'package:kuhaejwo_app/pages/home/home_view_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const url = '/splash';
  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Obx(() => Visibility(
          visible: controller.isVisible.value,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: controller.opacity.value,
            child: Scaffold(
              body: Container(
                color: isDarkMode ? const Color(0xFF001E2A) : CommonColor.white,
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SafeArea(child: SizedBox(height: 24)),
                            const Spacer(),
                            isDarkMode
                                ? Image.asset(
                                    'assets/images/konkuk_logo.png',
                                    width: 250,
                                    fit: BoxFit.scaleDown,
                                  )
                                : Image.asset(
                                    'assets/images/konkuk_logo.png',
                                    width: 250,
                                    fit: BoxFit.scaleDown,
                                  ),
                            const Spacer(),
                            Text(
                              "주변 대피소의 위치를 파악하기 위해\nGPS를 이용한 위치 설정이 필요합니다",
                              style: TextStyle(color: Colors.black.withOpacity(0.3)),
                              textAlign: TextAlign.center,
                            ),
                            const SafeArea(child: SizedBox(height: 24)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class SplashController extends GetxController {
  RxDouble opacity = 1.0.obs;
  RxBool isVisible = true.obs;

  @override
  void onInit() {
    moveToMain();
    super.onInit();
  }

  void moveToMain() {
    // Get.put(HomeController());

    Future.delayed(const Duration(milliseconds: 1), () {
      opacity.value = 0.0;
      Future.delayed(const Duration(milliseconds: 2), () async {
        isVisible.value = false;
        //로그인 여부 확인 및 라우트
        if (CommonStorageKey.accessToken.read.result && CommonStorageKey.accessToken.read.value != '') {
          try {
            var res = await AuthService().getUserInfo();
            if (res) {
              Get.put(SocketService());
              Get.offAllNamed(HomeViewPage.url);
            } else {
              Get.offAllNamed(SignInViewPage.url);
            }
          } catch (e) {
            Get.offAllNamed(SignInViewPage.url);
          }
        } else {
          Get.offAllNamed(SignInViewPage.url);
        }
      });
    });
  }
}
