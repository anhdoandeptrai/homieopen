import 'package:app_homieopen_3047/common/helpers/custom_toastification.dart';
import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:app_homieopen_3047/core/local/shared_prefs_service.dart';
import 'package:app_homieopen_3047/features/dashboard/cubits/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/is_authorized_cubit.dart';

class LogoutAccount {
  static Future<void> logout(BuildContext context) async {
    sl<SharedPrefsService>().clearLocalData();
    context.read<DashboardCubit>().choosePage(0);
    context.read<IsAuthorizedCubit>().isAuthorized();
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   DashboardPage.route(),
    //   (route) => false,
    // );
    // Future.delayed(Duration.zero, () {
    //   resetDependencies();
    // });
    CustomToastification.success(context, "Đăng xuất thành công!");
  }
}
