import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart' as dio_lib;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/common/utils/common_storage.dart';
import 'package:kuhaejwo_app/common/http_model/GetMateOfferListResponse.dart';
import 'package:kuhaejwo_app/common/http_model/GetUserResponse.dart';
import 'package:kuhaejwo_app/common/http_model/PostLoginResponse.dart';
import 'package:kuhaejwo_app/common/utils/service_response.dart';

class HttpServiceManager {
  // dio instance

  final Logger _logger = Common.logger;

  logd(dynamic dynamic) async {
    compute(_logger.d, dynamic.toString());
  }

  logv(dynamic dynamic) async {
    compute(_logger.v, dynamic.toString());
  }

  logw(dynamic dynamic) async {
    compute(_logger.w, dynamic.toString());
  }

  static final HttpServiceManager _instance = HttpServiceManager._internal();

  factory HttpServiceManager() => _instance;
  HttpServiceManager._internal() {
    Common.logger.d('HttpServiceManager._internal() called!!!');
  }

  Future<ServiceResponse<PostLoginResponse>> postLogin({required String email, required String password}) async {
    try {
      var res = await dio_lib.Dio().post('/api/login'.getUrl, data: jsonEncode({"email": email, "password": password}));
      if (res.data["code"] == 200) {
        PostLoginResponse postLoginResponse = PostLoginResponse.fromJson(res.data["data"]);
        CommonStorageKey.accessToken.write(postLoginResponse.accessToken);
        CommonStorageKey.refreshToken.write(postLoginResponse.refreshToken);
        return ServiceResponse(result: true, value: postLoginResponse);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? e.error.message ?? "");
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<PostLoginResponse>> postSignUp({required String email, required String password, required String name}) async {
    try {
      var res = await dio_lib.Dio().post('/api/signup'.getUrl, data: jsonEncode({"email": email, "password": password, "name": name}));
      if (res.data["code"] == 200) {
        return ServiceResponse(result: true);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? e.error.message ?? "");
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<GetMateOfferListResponse>> getMateOfferListResponse() async {
    try {
      var res = await dio_lib.Dio().get('/api/mateoffer/list'.getUrl);
      GetMateOfferListResponse getMateOfferListResponse = GetMateOfferListResponse.fromJson(res.data);
      if (res.data["code"] == 200) {
        return ServiceResponse(result: true, value: getMateOfferListResponse);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<GetUserResponse>> getUserInfo() async {
    try {
      var res = await (await authDio()).get('/api/users'.getUrl);
      GetUserResponse getUserResponse = GetUserResponse.fromJson(res.data["data"]);
      if (res.data["code"] == 200) {
        return ServiceResponse(result: true, value: getUserResponse);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<UserBasicInfoResponse>> getUserBasicInfo() async {
    //기본info get method
    try {
      var res = await (await authDio()).get('/api/users/info'.getUrl);
      UserBasicInfoResponse userBasicInfoResponse = UserBasicInfoResponse.fromJson(res.data["data"]);
      if (res.data["code"] == 200) {
        return ServiceResponse(result: true, value: userBasicInfoResponse);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<UserBasicInfoResponse>> userBasicInfoUpdate({required Map data, bool isInit = false}) async {
    try {
      var res = isInit
          ? await (await authDio()).post('/api/users/info'.getUrl, data: jsonEncode(data))
          : await (await authDio()).put('/api/users/info'.getUrl, data: jsonEncode(data));
      UserBasicInfoResponse basicInfoResponse = UserBasicInfoResponse.fromJson(res.data["data"]);
      if (res.data["code"] == 200) {
        return ServiceResponse(result: true, value: basicInfoResponse);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<UserInfoDetailResponse>> getUserDetailInfo() async {
    try {
      var res = await (await authDio()).get('/api/users/infoDetail'.getUrl);
      UserInfoDetailResponse userInfoDetailResponse = UserInfoDetailResponse.fromJson(res.data["data"]);
      if (res.data["code"] == 200) {
        return ServiceResponse(result: true, value: userInfoDetailResponse);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<UserPreferResponse>> getUserPrefer() async {
    try {
      var res = await (await authDio()).get('/api/users/prefer'.getUrl);
      UserPreferResponse userPreferResponse = UserPreferResponse.fromJson(res.data["data"]);
      if (res.data["code"] == 200) {
        return ServiceResponse(result: true, value: userPreferResponse);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<UserInfoDetailResponse>> userDetailInfoUpdate({required Map data, bool isInit = false}) async {
    try {
      var res = isInit
          ? await (await authDio()).post('/api/users/infoDetail'.getUrl, data: jsonEncode(data))
          : await (await authDio()).put('/api/users/infoDetail'.getUrl, data: jsonEncode(data));
      UserInfoDetailResponse userInfoDetailResponse = UserInfoDetailResponse.fromJson(res.data["data"]);
      if (res.data["code"] == 200) {
        return ServiceResponse(result: true, value: userInfoDetailResponse);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<UserPreferResponse>> userPreferUpdate({required Map data, bool isInit = false}) async {
    try {
      var res = isInit
          ? await (await authDio()).post('/api/users/prefer'.getUrl, data: jsonEncode(data))
          : await (await authDio()).put('/api/users/prefer'.getUrl, data: jsonEncode(data));
      UserPreferResponse userInfoDetailResponse = UserPreferResponse.fromJson(res.data["data"]);
      if (res.data["code"] == 200) {
        return ServiceResponse(result: true, value: userInfoDetailResponse);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<MateOfferResponse>> getMyMateOffer() async {
    try {
      var res = await (await authDio()).get('/api/mateoffer'.getUrl);

      MateOfferResponse myMateOffer = MateOfferResponse.fromJson(res.data["data"]);
      if (res.data["code"] == 200) {
        return ServiceResponse(result: true, value: myMateOffer);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<MateOfferResponse>> mateOfferUpdate({required Map data, bool isInit = false}) async {
    try {
      var res = isInit
          ? await (await authDio()).post('/api/mateoffer'.getUrl, data: jsonEncode(data))
          : await (await authDio()).put('/api/mateoffer'.getUrl, data: jsonEncode(data));
      MateOfferResponse mateOfferResponse = MateOfferResponse.fromJson(res.data["data"]);
      if (res.data["code"] == 200) {
        return ServiceResponse(result: true, value: mateOfferResponse);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<String>> postsendConfirmEmail({required String email}) async {
    try {
      var data = {"email": email};
      var res = await (await authDio()).post('/confirm-email'.getUrl, data: jsonEncode(data));

      String returnEmail = res.data["data"];
      if (res.data["code"] == 200) {
        return ServiceResponse(result: true, value: returnEmail);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<bool>> getIsAccountConfirmed() async {
    try {
      var res = await (await authDio()).get('/api/auth'.getUrl);

      bool isConfirmed = (res.data["data"]);
      if (res.data["code"] == 200) {
        return ServiceResponse(result: true, value: isConfirmed);
      }
      return ServiceResponse(result: false, errorMsg: res.data["msg"] ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<String>> postUpdateUserProfile(XFile file) async {
    try {
      // dio_lib.FormData data = dio_lib.FormData.fromMap({
      //   'file':
      //       await dio_lib.MultipartFile.fromFile(file.path, filename: 'userprofile_${file.name}', contentType: MediaType('image', file.name.split('.').last))
      // });
      File a = File(file.path);
      dio_lib.Dio dio = await authDio();
      dio.options.contentType = 'multipart/form-data';

      dio_lib.FormData data = dio_lib.FormData.fromMap({"file": await dio_lib.MultipartFile.fromFile(a.path, filename: "dd")});
      var res = await dio.post('/api/users/profileImage'.getUrl, data: data);

      return ServiceResponse(result: true, value: res.data["data"]);
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      logv(e);
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<String>> getUserProfileImage() async {
    try {
      var res = await (await authDio()).get('/api/users/profileImage'.getUrl);

      var i = Image.memory(base64Decode(res.data));

      return ServiceResponse(result: true, value: res.data["data"]);
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      logv(e);
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  // Future<ServiceResponse<GetUserResponse>> getUser() async {
  //   try {
  //     var res = await (await authDio()).get('/api/get-user'.getUrl);
  //     GetUserResponse getUserResponse = GetUserResponse.fromJson(res.data);
  //     if (getUserResponse.code == 200) {
  //       return ServiceResponse(result: true, value: getUserResponse);
  //     }
  //     return ServiceResponse(result: false, errorMsg: getUserResponse.msg ?? '오류가 발생했습니다');
  //   } on dio_lib.DioError catch (e) {
  //     return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
  //   } catch (e) {
  //     return ServiceResponse(result: false, errorMsg: e.toString());
  //   }
  // }

  Future<dio_lib.Dio> authDio() async {
    final dio_lib.Dio dio = dio_lib.Dio();

    dio.interceptors.clear();

    dio.interceptors.add(dio_lib.InterceptorsWrapper(onRequest: (options, handler) async {
      // 기기에 저장된 AccessToken 로드
      String? accessToken = CommonStorageKey.accessToken.read.value;
      // 매 요청마다 헤더에 AccessToken을 포함
      options.headers['X-AUTH-TOKEN'] = accessToken;
      return handler.next(options);
    }, onError: (error, handler) async {
      // 인증 오류가 발생했을 경우: AccessToken의 만료
      if (error.response?.statusCode == 401) {
        // 기기에 저장된 AccessToken과 RefreshToken 로드

        String? accessToken;
        if (CommonStorageKey.accessToken.read.result) {
          accessToken = CommonStorageKey.accessToken.read.value;
        }
        String? refreshToken;
        if (CommonStorageKey.refreshToken.read.result) {
          refreshToken = CommonStorageKey.refreshToken.read.value;
        }

        // 토큰 갱신 요청을 담당할 dio 객체 구현 후 그에 따른 interceptor 정의
        var refreshDio = dio_lib.Dio();

        refreshDio.interceptors.clear();

        refreshDio.interceptors.add(dio_lib.InterceptorsWrapper(onError: (error, handler) async {
          // 다시 인증 오류가 발생했을 경우: RefreshToken의 만료
          if (error.response?.statusCode == 401) {
            // 기기의 자동 로그인 정보 삭제
            await CommonStorageKey().deleteAll();

            // . . .
            // 로그인 만료 dialog 발생 후 로그인 페이지로 이동
            // . . .
          }
          return handler.next(error);
        }));

        // 토큰 갱신 API 요청 시 AccessToken(만료), RefreshToken 포함

        if (refreshToken == null) return;

        // 토큰 갱신 API 요청

        final refreshResponse = await refreshDio.post('${Common.baseUrl}/api/reissue',
            data: jsonEncode({
              'accessToken': accessToken,
              'refreshToken': refreshToken,
            }));

        // response로부터 새로 갱신된 AccessToken과 RefreshToken 파싱
        final newAccessToken = refreshResponse.data['accessToken'];
        final newRefreshToken = refreshResponse.data['refreshToken'];

        // 기기에 저장된 AccessToken과 RefreshToken 갱신
        CommonStorageKey.accessToken.write(newAccessToken);
        CommonStorageKey.refreshToken.write(newRefreshToken);

        // AccessToken의 만료로 수행하지 못했던 API 요청에 담겼던 AccessToken 갱신
        error.requestOptions.headers['X-AUTH-TOKEN'] = newAccessToken;

        // 수행하지 못했던 API 요청 복사본 생성
        final clonedRequest = await dio.request(error.requestOptions.path,
            options: dio_lib.Options(method: error.requestOptions.method, headers: error.requestOptions.headers),
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters);

        // API 복사본으로 재요청
        return handler.resolve(clonedRequest);
      }

      return handler.next(error);
    }));

    return dio;
  }
}

extension ResponseExtension on dio_lib.Response {
  bool get isSuccesful => statusCode == 200;
}
