
import 'package:app_homieopen_3047/core/assets/app_image.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final VoidCallback onEdit;

  const ProfileHeader({required this.name, required this.onEdit, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                color: AppColor.turquoise500,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.turquoise200, width: 3),
              ),
              child: CircleAvatar(
                radius: 54,
                backgroundColor: AppColor.turquoise200,
                backgroundImage: AssetImage(AppImage.avatarSample),
              ),
            ),
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                width: 28,
                height: 25,
                decoration: BoxDecoration(
                  color: AppColor.turquoise500,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white, size: 14),
                  onPressed: onEdit,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
