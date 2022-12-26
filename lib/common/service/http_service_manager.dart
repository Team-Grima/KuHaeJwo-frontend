import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart' as dio_lib;
import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart';
import 'package:pet_app/common/common.dart';
import 'package:pet_app/common/common_storage.dart';
import 'package:pet_app/common/http_model/GetMateOfferListResponse.dart';
import 'package:pet_app/common/http_model/GetUserDetailResponse.dart';
import 'package:pet_app/common/http_model/PostLoginResponse.dart';

import 'package:pet_app/common/service_response.dart';

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
      PostLoginResponse postLoginResponse = PostLoginResponse.fromJson(res.data);
      if (postLoginResponse.code == 200) {
        CommonStorageKey.accessToken.write(postLoginResponse.data!.accessToken);
        CommonStorageKey.refreshToken.write(postLoginResponse.data!.refreshToken);
        return ServiceResponse(result: true, value: postLoginResponse);
      }
      return ServiceResponse(result: false, errorMsg: postLoginResponse.msg ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<GetMateOfferListResponse>> getMateOfferListResponse() async {
    try {
      var res = await (await authDio()).get('/api/mateoffer/list'.getUrl);
      GetMateOfferListResponse getMateOfferListResponse = GetMateOfferListResponse.fromJson(res.data);
      if (getMateOfferListResponse.code == 200) {
        return ServiceResponse(result: true, value: getMateOfferListResponse);
      }
      return ServiceResponse(result: false, errorMsg: getMateOfferListResponse.msg ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

  Future<ServiceResponse<GetUserResponse>> getUser() async {
    try {
      var res = await (await authDio()).get('/api/get-user'.getUrl);
      GetUserResponse getUserResponse = GetUserResponse.fromJson(res.data);
      if (getUserResponse.code == 200) {
        return ServiceResponse(result: true, value: getUserResponse);
      }
      return ServiceResponse(result: false, errorMsg: getUserResponse.msg ?? '오류가 발생했습니다');
    } on dio_lib.DioError catch (e) {
      return ServiceResponse(result: false, errorMsg: e.response?.data["msg"] ?? '오류가 발생했습니다');
    } catch (e) {
      return ServiceResponse(result: false, errorMsg: e.toString());
    }
  }

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
