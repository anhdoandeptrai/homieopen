import 'package:app_homieopen_3047/common/widgets/check_login.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:app_homieopen_3047/features/notifications/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../widgets/notification_list.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({super.key});

  @override
  State<NotificationListPage> createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(LoadNotifications());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == '/notifications') {
      final state = context.read<NotificationBloc>().state;
      if (state is NotificationDetailLoaded) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.read<NotificationBloc>().add(LoadNotifications());
          }
        });
      }
    }
  }

  void _navigateToDetail(NotificationModel notification) {
    print('Điều hướng tới thông báo ID: ${notification.id}');
    Navigator.of(context).pushNamed(
      '/notification/detail',
      arguments: notification.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.oslo950,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          'Thông báo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: CheckLogin(
        text: "nhận được thông báo",
        child: BlocListener<NotificationBloc, NotificationState>(
          listener: (context, state) {
            if (state is NotificationActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColor.turquoise700,
                ),
              );
            } else if (state is NotificationActionFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.error), backgroundColor: Colors.red),
              );
            }
          },
          child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationInitial) {
                context.read<NotificationBloc>().add(LoadNotifications());
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.turquoise500,
                  ),
                );
              }

              if (state is NotificationsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.turquoise500,
                  ),
                );
              }

              return NotificationList(
                notifications:
                    state is NotificationsLoaded ? state.notifications : [],
                onNotificationTap: (notification) =>
                    _navigateToDetail(notification),
              );
            },
          ),
        ),
      ),
    );
  }
}
