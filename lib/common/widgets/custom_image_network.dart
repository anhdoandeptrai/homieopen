import 'package:app_homieopen_3047/core/assets/app_image.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomImageNetwork extends StatelessWidget {
  final String? image;
  final double? width;
  final double? height;
  final bool isRadius;
  final double? radius;
  final bool isRounded;
  final bool isAvatar;
  final bool isAPI;
  final BoxFit fit;
  const CustomImageNetwork(
      {super.key,
      this.image,
      this.width,
      this.height,
      this.isRadius = false,
      this.radius,
      this.isRounded = false,
      this.isAvatar = false,
      this.isAPI = false,
      this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    debugPrint("Image: $image");
    return Visibility(
      visible: isRadius,
      replacement: Visibility(
        visible: isRounded,
        replacement: _image(),
        child: ClipOval(
          child: _image(),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          radius ?? 12.sp,
        ),
        child: _image(),
      ),
    );
  }

  Widget _image() {
    if (image == null || image!.isEmpty) {
      return Image.asset(
        isAvatar ? AppImage.userPlaceholder : AppImage.imagePlaceholder,
        width: width ?? double.infinity,
        height: height,
        fit: BoxFit.cover,
      );
    }
    return CachedNetworkImage(
      imageUrl: isAPI ? "https://3047.mevivu.net$image" : image!,
      alignment: Alignment.center,
      width: width ?? double.infinity,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: SpinKitFadingCube(
          color: AppColor.turquoise500,
          size: 18.w,
        ),
      ),
      errorWidget: (context, url, error) => Image.asset(
        isAvatar ? AppImage.userPlaceholder : AppImage.imagePlaceholder,
        width: width ?? double.infinity,
        height: height,
        fit: fit,
      ),
    );
  }
}
