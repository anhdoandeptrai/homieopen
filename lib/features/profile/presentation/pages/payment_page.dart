import 'package:flutter/material.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import '../widgets/package_info_section.dart';
import '../widgets/subscription_period_section.dart';
import '../widgets/payment_method_section.dart';
import '../widgets/payment_success_dialog.dart';
import '../widgets/custom_switch.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool autoRenew = false;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    final title = args['title'] ?? 'Gói Vip 1';
    final price = args['price'] ?? '320.000 VND';
    final duration = args['duration'] ?? '30 ngày';

    return Scaffold(
      backgroundColor: AppColor.oslo950,
      appBar: AppBar(
        backgroundColor: AppColor.oslo950,
        foregroundColor: Colors.white,
        title: const Text(
          'Thanh toán gói',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
              child: Container(
                color: AppColor.oslo950,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PackageInfoSection(
                      title: title,
                      price: price,
                      duration: duration,
                    ),
                    const SizedBox(height: 16),
                    const SubscriptionPeriodSection(),
                    const SizedBox(height: 16),
                    const PaymentMethodSection(),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      color: Colors.black,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Row(
                              children: [
                                const Text(
                                  'Tự động gia hạn gói này',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                CustomSwitch(
                                  value: autoRenew,
                                  onChanged: (value) {
                                    setState(() {
                                      autoRenew = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  PaymentSuccessDialog.show(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.turquoise500,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Thanh toán',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
