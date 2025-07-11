import 'package:app_homieopen_3047/common/helpers/custom_toastification.dart';
import 'package:app_homieopen_3047/common/helpers/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class AuthBlocConsumer extends StatelessWidget {
  const AuthBlocConsumer({
    super.key,
    this.navigatorPage,
    this.successText,
    required this.onSuccess,
    required this.child,
  });
  final Widget child;
  final Widget? navigatorPage;
  final String? successText;
  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showLoading(context);
        } else if (state is AuthFailure) {
          Navigator.pop(context);
          CustomToastification.error(context, state.message);
        } else if (state is AuthSuccess) {
          Navigator.pop(context);
          onSuccess();
          if (navigatorPage != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => navigatorPage!,
              ),
            );
          }
          if (successText != null) {
            CustomToastification.success(context, successText!);
          }
        }
      },
      builder: (context, state) {
        return child;
      },
    );
  }
}
