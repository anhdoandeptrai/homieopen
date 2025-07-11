import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/is_authorized_cubit.dart';

typedef IsAuthorizedWidgetBuilder = Widget Function(bool isAuthorized);

class CustomIsAuthorized extends StatelessWidget {
  final IsAuthorizedWidgetBuilder builder;

  const CustomIsAuthorized({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<IsAuthorizedCubit, bool, bool>(
      selector: (state) => state,
      builder: (context, isAuthorized) {
        return builder(isAuthorized);
      },
    );
  }
}
