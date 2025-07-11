import 'dart:io';
import 'package:app_homieopen_3047/common/helpers/show_alert_dialog.dart';
import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:app_homieopen_3047/features/auth/presentation/pages/signin_page.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../local/shared_prefs_service.dart';
import '../utils/constants/endpoint_constants.dart';
import '../utils/navigator_key_service.dart';

class AppInterceptor extends Interceptor {
  final SharedPrefsService _sharedPrefsService;

  final Set<String> _noAuthUrls = {
    EndpointConstants.login,
    EndpointConstants.getRecommendedVideos,
    EndpointConstants.getShortVideos,
    EndpointConstants.getLongVideos,
    // EndpointConstants.register,
    // EndpointConstants.verify,
    // EndpointConstants.resetPassword,
    // EndpointConstants.resendOtp,
    // EndpointConstants.createNewPassword,
  };

  AppInterceptor({required SharedPrefsService sharedPrefsService})
      : _sharedPrefsService = sharedPrefsService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!_noAuthUrls.contains(options.path)) {
      final token =
          _sharedPrefsService.getString(SharedPrefsValues.accessToken);
      if (token == null) {
        // In addition
        showAlertDialog(
          sl<NavigatorKeyService>().context!,
          () {
            sl<SharedPrefsService>().clearLocalData();
            Navigator.pushAndRemoveUntil(
              sl<NavigatorKeyService>().context!,
              SigninPage.route(),
              (route) => false,
            );
          },
          () {
            sl<SharedPrefsService>().clearLocalData();
            Navigator.pushAndRemoveUntil(
              sl<NavigatorKeyService>().context!,
              SigninPage.route(),
              (route) => false,
            );
          },
          'End of session',
          'Please log in again',
          "Logout",
          "Cancel",
        );
      } else {
        options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
        handler.next(options);
      }
    } else {
      handler.next(options);
    }
  }
}
