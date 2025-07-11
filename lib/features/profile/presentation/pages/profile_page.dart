import 'package:app_homieopen_3047/common/cubits/is_authorized_cubit.dart';
import 'package:app_homieopen_3047/common/helpers/logout_account.dart';
import 'package:app_homieopen_3047/common/helpers/show_alert_dialog.dart';
import 'package:app_homieopen_3047/core/assets/app_image.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:app_homieopen_3047/features/profile/presentation/pages/guest_profile_page.dart';
import 'package:app_homieopen_3047/features/profile/presentation/widgets/profile/profile_header.dart';
import 'package:app_homieopen_3047/features/profile/presentation/widgets/profile/profile_package_info.dart';
import 'package:app_homieopen_3047/features/profile/presentation/widgets/profile/profile_section.dart';
import 'package:app_homieopen_3047/features/profile/presentation/widgets/profile/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/profile/profile_package_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentPackage = 0;
  //tu them du lieu de test cho giong ui ben figma
  final packages = [
    {
      'name': 'Dùng thử',
      'desc': '',
      'button': 'Đăng ký gói',
      'color': AppColor.turquoise300,
      'expire': false,
    },
    {
      'name': 'Gói Vip 1',
      'desc': '',
      'button': 'Gia hạn gói',
      'color': AppColor.turquoise300,
      'expire': false,
    },
    {
      'name': 'Gói Vip 1',
      'desc': 'Thời hạn gói chỉ còn 10 ngày',
      'button': 'Gia hạn ngay',
      'color': AppColor.turquoise300,
      'expire': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final package = packages[currentPackage];
    return BlocSelector<IsAuthorizedCubit, bool, bool>(
      selector: (state) => state,
      builder: (context, isAuthorized) {
        if (!isAuthorized) {
          return GuestProfilePage();
        }
        return Scaffold(
          backgroundColor: AppColor.oslo950,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 220,
                  child: Image.asset(
                    AppImage.wave,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      ProfileHeader(
                        name: 'Nguyễn Thị Hoa',
                        onEdit: () {},
                      ),
                      SizedBox(height: 8.h),
                      ProfilePackageInfo(package: package),
                      SizedBox(height: 10.h),
                      ProfilePackageButton(
                        package: package,
                        onPressed: () {},
                      ),
                      SizedBox(height: 24.h),
                      ProfileSection(
                        title: 'Tài khoản',
                        children: [
                          ProfileTile(
                            icon: Icons.account_circle_outlined,
                            label: 'Thông tin tài khoản',
                            onTap: () {},
                          ),
                          ProfileTile(
                            icon: Icons.password_outlined,
                            label: 'Đổi mật khẩu',
                            onTap: () {},
                            iconColor: AppColor.turquoise300,
                          ),
                        ],
                      ),
                      ProfileSection(
                        title: 'Quản lý',
                        children: [
                          ProfileTile(
                            icon: Icons.card_membership_outlined,
                            label: 'Gói thành viên',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/membership-packages');
                            },
                          ),
                          ProfileTile(
                            icon: Icons.credit_card_outlined,
                            label: 'Liên kết thẻ',
                            onTap: () {
                              Navigator.pushNamed(context, '/linked-cards');
                            },
                          ),
                        ],
                      ),
                      ProfileSection(
                        title: 'Hỗ trợ',
                        children: [
                          ProfileTile(
                            icon: Icons.phone_outlined,
                            label: 'Liên hệ',
                            onTap: () {},
                          ),
                          ProfileTile(
                            icon: Icons.help_outline,
                            label: 'Câu hỏi thường gặp',
                            onTap: () {},
                          ),
                          ProfileTile(
                            icon: Icons.people_outline,
                            label: 'Về chúng tôi',
                            onTap: () {},
                          ),
                          ProfileTile(
                            icon: Icons.policy_outlined,
                            label: 'Chính sách',
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showAlertDialog(
                              context,
                              () async {
                                LogoutAccount.logout(context);
                              },
                              () {},
                              "Thông báo",
                              "Bạn có muốn đăng xuất tài khoản không?",
                              "Đồng ý",
                              "Ở lại",
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.turquoise900,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            padding: EdgeInsets.symmetric(vertical: 16.w),
                          ),
                          child: Text(
                            'Đăng xuất',
                            style: TextStyle(
                              color: AppColor.turquoise500,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
