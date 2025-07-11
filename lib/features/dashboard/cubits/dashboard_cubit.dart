import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/presentation/pages/home_page.dart';
import '../../list/presentation/pages/list_page.dart';
import '../../notifications/presentation/pages/notification_list_page.dart';
import '../../profile/presentation/pages/profile_page.dart';

class DashboardCubit extends Cubit<int> {
  DashboardCubit() : super(0);

  List<Widget> getPages(int currentIndex) => [
        HomePage(isVisible: currentIndex == 0),
        ListPage(),
        NotificationListPage(),
        ProfilePage(),
      ];

  final List<String> text = [
    "Trang chủ",
    "Danh sách",
    "Thông báo",
    "Cá nhân",
  ];

  final List<IconData> icons = [
    Icons.home,
    Icons.live_tv_outlined,
    Icons.notifications,
    Icons.person,
  ];

  void choosePage(int val) => emit(val);
}
