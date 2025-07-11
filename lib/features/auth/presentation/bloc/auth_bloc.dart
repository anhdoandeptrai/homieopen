import 'package:app_homieopen_3047/core/local/shared_prefs_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/params/login_params.dart';
import '../../data/params/register_params.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;
  final SharedPrefsService _sharedPrefsService;
  final RegisterUsecase _registerUsecase;

  AuthBloc({
    required LoginUsecase loginUsecase,
    required SharedPrefsService sharedPrefsService,
    required RegisterUsecase registerUsecase,
   
  })  : _loginUsecase = loginUsecase,
        _sharedPrefsService = sharedPrefsService,
        _registerUsecase = registerUsecase,
        super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
  }

  void _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _loginUsecase.call(event.params);

    res.fold((failure) => emit(AuthFailure(message: failure.message)), (token) {
      _sharedPrefsService.saveString(SharedPrefsValues.accessToken, token);
      emit(AuthSuccess());
    });
  }

  void _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _registerUsecase.call(event.params);

    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (message) => emit(AuthSuccess()),
    );
  }


    
}