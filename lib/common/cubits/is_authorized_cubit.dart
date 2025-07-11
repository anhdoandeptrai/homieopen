import 'package:app_homieopen_3047/core/local/shared_prefs_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsAuthorizedCubit extends Cubit<bool> {
  final SharedPrefsService _sharedPrefsService;

  IsAuthorizedCubit({required SharedPrefsService sharedPrefsService})
      : _sharedPrefsService = sharedPrefsService,
        super(false);

  void isAuthorized() {
    final String? token =
        _sharedPrefsService.getString(SharedPrefsValues.accessToken);
    emit(token != null);
  }
}