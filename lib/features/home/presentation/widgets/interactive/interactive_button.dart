import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InteractiveButton extends StatelessWidget {
  const InteractiveButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.color = Colors.white,
    required this.text,
    this.likeScale,
  });
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  final String text;
  //Button like
  final double? likeScale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 22.w, right: 6.w),
        color: Colors.transparent,
        child: Column(
          spacing: 6.h,
          children: [
            likeScale != null ? _buttonLike(context) : _icon(),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Icon(
      icon,
      size: 40.w,
      color: color,
    );
  }

  Widget _buttonLike(BuildContext context) =>
      Transform.scale(scale: likeScale, child: _icon());
}
