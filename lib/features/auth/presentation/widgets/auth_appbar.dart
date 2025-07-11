import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthAppbar extends StatelessWidget {
  const AuthAppbar({
    super.key,
    required this.title,
    required this.body,
    this.isBack = true,
    this.state = false,
    this.onBack,
  });
  final String title;
  final Widget body;
  final bool isBack;
  final bool state;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColor.oslo900,
        appBar: AppBar(
          leading: isBack
              ? IconButton(
                  onPressed: onBack ??
                      () {
                        Navigator.pop(context);
                      },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 22.w,
                    color: Colors.white,
                  ),
                )
              : SizedBox(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            title,
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            _buildBackgroundCircle(),
            const AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: SizedBox.expand(),
            ),
            SafeArea(child: body),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundCircle() {
    return SizedBox(
      height: ScreenUtil().screenHeight * 0.3,
      child: Stack(
        children: [
          ClipPath(
            clipper: state ? BottomWave2Clipper() : BottomWaveClipper(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: state ? Alignment.topLeft : Alignment.topRight,
                  end: state ? Alignment.topRight : Alignment.topLeft,
                  colors: [
                    AppColor.turquoise500,
                    AppColor.turquoise900,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);

    final firstControlPoint = Offset(size.width / 8, size.height - 150);
    final firstEndPoint = Offset(size.width / 3, size.height - 100);

    final secondControlPoint = Offset(size.width * 3 / 4, size.height);
    final secondEndPoint = Offset(size.width, size.height - 100);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomWave2Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);

    final firstControlPoint = Offset(size.width / 6, size.height);
    final firstEndPoint = Offset(size.width / 2, size.height - 100);

    final secondControlPoint = Offset(size.width * 5 / 6, size.height - 150);
    final secondEndPoint = Offset(size.width, size.height - 60);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
