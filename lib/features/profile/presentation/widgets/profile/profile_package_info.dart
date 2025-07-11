import 'package:flutter/material.dart';

class ProfilePackageInfo extends StatelessWidget {
  final Map package;
  const ProfilePackageInfo({required this.package, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: 'Gói hiện tại: ',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
            children: [
              TextSpan(
                text: package['name'] as String?,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        if (package['expire'] == true)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              package['desc'] as String,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
      ],
    );
  }
}
