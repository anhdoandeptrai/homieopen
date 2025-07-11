import 'package:flutter/material.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ProfileSection(
      {required this.title, required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColor.oslo900,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
