import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedHeartWidget extends StatefulWidget {
  const AnimatedHeartWidget({super.key, required this.position});
  final Offset position;

  @override
  State<AnimatedHeartWidget> createState() => _AnimatedHeartWidgetState();
}

class _AnimatedHeartWidgetState extends State<AnimatedHeartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1600),
    )..forward();

    _scaleAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 1.2, end: 1.0), weight: 3), // 0-300ms
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 10), // 300-1300ms
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.2), weight: 3), // 1300-1600ms
    ]).animate(_controller);

    _opacityAnimation = TweenSequence([
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 13), // 0-1300ms
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 0.0), weight: 3), // 1300-1600ms
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx - 30,
      top: widget.position.dy - 50,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(Icons.favorite, color: Colors.red, size: 150.w),
          ),
        ),
      ),
    );
  }
}
