import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.1,
      child: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColor.turquoise500,
        trackColor: Colors.grey.shade600,
        thumbColor: Colors.white,
      ),
    );
  }
}
