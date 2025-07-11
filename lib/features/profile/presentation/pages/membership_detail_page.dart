import 'package:app_homieopen_3047/core/assets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';

class MembershipDetailPage extends StatelessWidget {
  const MembershipDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    final packageType = args['packageType'] ?? 'vip1';
    final title = args['title'] ?? 'Gói Vip 1';
    final price = args['price'] ?? '320.000 VND';
    final duration = args['duration'] ?? '30 ngày';

    return Scaffold(
      backgroundColor: AppColor.oslo950,
      appBar: AppBar(
        backgroundColor: AppColor.oslo950,
        foregroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColor.turquoise500),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Image.asset(
                      AppImage.membership,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Gói $duration',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  price,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Lorem ipsum dolor sit amet consectetur. Viverra posuere purus accumsan nibh. Sit mauris commodo aliquam urna dictum egestas placerat a bibendum. Lacinia ac massa sit at venenatis egestas vestibulum augue vitae. Nisl lacinia convallis vitae at aliquam ornare mattis. Lorem ipsum dolor sit amet consectetur. Viverra posuere purus accumsan nibh. Sit mauris commodo aliquam urna dictum egestas placerat a bibendum. Lacinia ac massa sit at venenatis egestas vestibulum augue vitae. Nisl lacinia convallis vitae at aliquam ornare mattis. Lorem ipsum dolor sit amet consectetur. Viverra posuere purus accumsan nibh. Sit mauris commodo aliquam urna dictum egestas placerat a bibendum. Lacinia',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/payment', arguments: {
                    'packageType': packageType,
                    'title': title,
                    'price': price,
                    'duration': duration,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.turquoise500,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                ),
                child: const Text(
                  'Mua ngay',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
