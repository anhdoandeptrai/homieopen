import 'package:app_homieopen_3047/common/cubits/is_authorized_cubit.dart';
import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_theme.dart';
import 'package:app_homieopen_3047/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_homieopen_3047/features/dashboard/cubits/dashboard_cubit.dart';
import 'package:app_homieopen_3047/features/dashboard/cubits/notification_count_cubit.dart';
import 'package:app_homieopen_3047/features/dashboard/pages/dashboard_page.dart';
import 'package:app_homieopen_3047/features/home/presentation/bloc/video/video_bloc.dart';
import 'package:app_homieopen_3047/features/home/presentation/cubits/handle_search_cubit.dart';
import 'package:app_homieopen_3047/features/home/presentation/cubits/heart_animation_cubit.dart';
import 'package:app_homieopen_3047/features/home/presentation/cubits/button_like_cubit.dart';
import 'package:app_homieopen_3047/features/home/presentation/cubits/multi_pagination_cubit.dart';
import 'package:app_homieopen_3047/features/home/presentation/cubits/page_manage_cubit.dart';
import 'package:app_homieopen_3047/features/home/presentation/cubits/video_player_cubit.dart';
import 'package:app_homieopen_3047/features/list/presentation/cubits/change_list_page_cubit.dart';
import 'package:app_homieopen_3047/features/list/presentation/cubits/delete_video_item_cubit.dart';
import 'package:app_homieopen_3047/features/notifications/notification_module.dart';
import 'package:app_homieopen_3047/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:app_homieopen_3047/features/notifications/presentation/pages/notification_list_page.dart';
import 'package:app_homieopen_3047/features/notifications/repositories/notification_repository.dart';
import 'package:app_homieopen_3047/features/profile/presentation/bloc/card_bloc.dart';
import 'package:app_homieopen_3047/features/profile/profile_module.dart';
import 'package:app_homieopen_3047/features/profile/repositories/card_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: ".env");
  initializeDependencies();
  FlutterNativeSplash.remove();
  final notificationRepository = NotificationRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<IsAuthorizedCubit>()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<PageManageCubit>()),
        BlocProvider(create: (context) => sl<VideoPlayerCubit>()),
        BlocProvider(create: (context) => sl<HeartAnimationCubit>()),
        BlocProvider(create: (context) => sl<ButtonLikeCubit>()),
        BlocProvider(create: (context) => sl<DashboardCubit>()),
        BlocProvider(create: (context) => sl<NotificationCountCubit>()),
        BlocProvider(create: (context) => sl<ChangeListPageCubit>()),
        BlocProvider(create: (context) => sl<DeleteVideoItemCubit>()),
        BlocProvider(create: (context) => sl<ChangeContentPageCubit>()),
        BlocProvider(create: (context) => sl<HandleSearchCubit>()),
        BlocProvider(create: (context) => sl<MultiPaginationCubit>()),
        BlocProvider(
            create: (context) => sl<VideoBloc>()
              ..injectPaginationCubit(context.read<MultiPaginationCubit>())),
        BlocProvider<NotificationBloc>(
            create: (context) => NotificationBloc(
                notificationRepository: notificationRepository)),
        BlocProvider<CardBloc>(
            create: (context) => CardBloc(cardRepository: CardRepository())),
      ],
      child: const HomieOpenApp(),
    ),
  );
}

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class HomieOpenApp extends StatelessWidget {
  const HomieOpenApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = {
      // '/': (context) => const GuestPage(),
      // '/guest': (context) => const GuestPage(),
      '/notifications': (context) => const NotificationListPage(),
      ...NotificationModule.routes(),
      ...ProfileModule.routes(),
    };
    return ScreenUtilInit(
      designSize: const Size(473, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        theme: AppTheme.appTheme,
        themeMode: ThemeMode.dark,
        title: 'Homie Open App',
        home: child,
        routes: routes,
      ),
      child: DashboardPage(),
    );
  }
}
