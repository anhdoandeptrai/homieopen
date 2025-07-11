part of 'injection.dart';

final GetIt sl = GetIt.instance;

void initializeDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton(() => SharedPrefsService(prefs: sharedPrefs))
    ..registerLazySingleton(
        () => DioClient(sharedPrefsService: sl<SharedPrefsService>()))
    ..registerLazySingleton(() => NavigatorKeyService())
    ..registerFactory(() => DashboardCubit())
    ..registerLazySingleton(
        () => IsAuthorizedCubit(sharedPrefsService: sl<SharedPrefsService>()))
    ..registerFactory(() => ObscureTextCubit())
    ..registerFactory(() => CountdownCubit())
    ..registerFactory(() => HeartAnimationCubit())
    ..registerFactory(() => NotificationCountCubit())
    ..registerFactory(() => PageManageCubit())
    ..registerFactory(() => VideoPlayerCubit())
    ..registerFactory(() => ButtonLikeCubit())
    ..registerFactory(() => ChangeListPageCubit())
    ..registerFactory(() => DeleteVideoItemCubit())
    ..registerFactory(() => HasValueCubit())
    ..registerFactory(() => DynamicTextFieldCubit())
    ..registerFactory(() => AnimatedButtonCubit())
    ..registerFactory(() => ChangeContentPageCubit())
    ..registerFactory(() => AddContentCubit())
    ..registerFactory(() => HandleSearchCubit())
    ..registerFactory(() => VideoControlCubit())
    ..registerFactory(() => ReadMoreCubit())
    ..registerFactory(() => SaveCollectionCubit())
    ..registerFactory(() => MultiPaginationCubit());

  _authInit();
  _homeInit();
}

void resetDependencies() {
  sl.resetLazySingleton<DashboardCubit>();
  sl.resetLazySingleton<SharedPrefsService>();
  sl.resetLazySingleton<DioClient>();
  sl.resetLazySingleton<NavigatorKeyService>();
}

void _authInit() {
  sl
    ..registerFactory<AuthRemoteDatasource>(
        () => AuthRemoteDatasourceImpl(dioClient: sl<DioClient>()))
    ..registerFactory<AuthRepository>(() =>
        AuthRepositoryImpl(authRemoteDataSource: sl<AuthRemoteDatasource>()))
    ..registerFactory(() => LoginUsecase(authRepository: sl<AuthRepository>()))
    ..registerFactory(
        () => RegisterUsecase(authRepository: sl<AuthRepository>()))
    ..registerFactory(() => AuthBloc(
        loginUsecase: sl<LoginUsecase>(),
        sharedPrefsService: sl<SharedPrefsService>(),
        registerUsecase: sl<RegisterUsecase>()));
}

void _homeInit() {
  sl
    ..registerFactory<HomeRemoteDatasource>(
        () => HomeRemoteDatasourceImpl(dioClient: sl<DioClient>()))
    ..registerFactory<HomeRepository>(() =>
        HomeRepositoryImpl(homeRemoteDatasource: sl<HomeRemoteDatasource>()))
    ..registerFactory(
        () => GetRecommendedVideosUsecase(homeRepository: sl<HomeRepository>()))
    ..registerFactory(
        () => GetShortVideosUsecase(homeRepository: sl<HomeRepository>()))
    ..registerFactory(
        () => GetLongVideosUsecase(homeRepository: sl<HomeRepository>()))
    ..registerFactory(() => VideoBloc(
        getRecommendedVideosUsecase: sl<GetRecommendedVideosUsecase>(),
        getShortVideosUsecase: sl<GetShortVideosUsecase>(),
        getLongVideosUsecase: sl<GetLongVideosUsecase>(),
        paginationCubit: sl<MultiPaginationCubit>()));
}
