import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';

class ProfilePackageButton extends StatelessWidget {
  final Map package;
  final VoidCallback onPressed;
  const ProfilePackageButton(
      {required this.package, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00C8E3),
        foregroundColor: AppColor.oslo100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      ),
      child: Text(package['button'] as String),
    );
  }
}
