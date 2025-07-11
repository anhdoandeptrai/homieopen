import 'package:flutter/material.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:app_homieopen_3047/core/assets/app_image.dart';

class MembershipPackagesPage extends StatelessWidget {
  const MembershipPackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.oslo950,
      appBar: AppBar(
        backgroundColor: AppColor.oslo950,
        foregroundColor: Colors.white,
        title: const Text(
          'Gói thành viên',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColor.turquoise500),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildPackageCard(
              context,
              title: 'Gói Vip 1',
              subtitle: 'Gói 30 ngày',
              price: '320.000 VND',
              description:
                  'Lorem ipsum dolor sit amet consectetur. Viverra posuere purus accumsan nibh. Sit mauris commodo aliquam urna dictum egestas placerat a bibendum. Lacinia ac massa sit at venenatis egestas vestibul...',
              isRecommended: true,
              onPressed: () {
                Navigator.pushNamed(context, '/membership-detail', arguments: {
                  'packageType': 'vip1',
                  'title': 'Gói Vip 1',
                  'price': '320.000 VND',
                  'duration': '30 ngày'
                });
              },
            ),
            const SizedBox(height: 16),
            _buildPackageCard(
              context,
              title: 'Gói Vip 2',
              subtitle: 'Gói 60 ngày',
              price: '599.000 VND',
              description:
                  'Lorem ipsum dolor sit amet consectetur. Viverra posuere purus accumsan nibh. Sit mauris commodo aliquam urna dictum egestas placerat a bibendum. Lacinia ac massa sit at venenatis egestas vestibul...',
              isRecommended: false,
              onPressed: () {
                Navigator.pushNamed(context, '/membership-detail', arguments: {
                  'packageType': 'vip2',
                  'title': 'Gói Vip 2',
                  'price': '599.000 VND',
                  'duration': '60 ngày'
                });
              },
            ),
            const SizedBox(height: 16),
            _buildPackageCard(
              context,
              title: 'Gói Vip 3',
              subtitle: 'Gói 90 ngày',
              price: '899.000 VND',
              description:
                  'Lorem ipsum dolor sit amet consectetur. Viverra posuere purus accumsan nibh. Sit mauris commodo aliquam urna dictum egestas placerat a bibendum. Lacinia ac massa sit at venenatis egestas vestibul...',
              isRecommended: false,
              onPressed: () {
                Navigator.pushNamed(context, '/membership-detail', arguments: {
                  'packageType': 'vip3',
                  'title': 'Gói Vip 3',
                  'price': '899.000 VND',
                  'duration': '90 ngày'
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String price,
    required String description,
    required bool isRecommended,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColor.turquoise800,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      AppImage.membership,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        price,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.turquoise500,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      elevation: 0,
                      minimumSize: Size.zero,
                    ),
                    child: const Text(
                      'Mua ngay',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
