import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'credit_card_widget.dart';
import '../bloc/card_bloc.dart';
import '../bloc/card_event.dart';
import '../bloc/card_state.dart';

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  @override
  void initState() {
    super.initState();
    // Load default card when widget initializes
    context.read<CardBloc>().add(const LoadDefaultCard());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Thẻ thanh toán',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/change-payment-card');
                },
                child: const Text(
                  'Đổi thẻ',
                  style: TextStyle(
                    color: AppColor.turquoise500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<CardBloc, CardState>(
            builder: (context, state) {
              if (state is CardLoading) {
                return Container(
                  height: 160, // Giảm chiều cao cho chế độ minimal
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.turquoise500,
                    ),
                  ),
                );
              }

              if (state is DefaultCardLoaded && state.defaultCard != null) {
                final card = state.defaultCard!;
                return CreditCardWidget(
                  cardNumber: card.cardNumber,
                  cardHolder: card.cardHolder,
                  accountNumber: card.accountNumber,
                  cvv: card.cvv,
                  expiryDate: card.expiryDate,
                  isDefault: card.isDefault,
                  height: 160, // Giảm chiều cao cho chế độ minimal
                  roundedCorners: true,
                  showMinimalInfo: true, // Chỉ hiển thị thông tin cơ bản
                );
              }

              if (state is CardsLoaded && state.defaultCard != null) {
                final card = state.defaultCard!;
                return CreditCardWidget(
                  cardNumber: card.cardNumber,
                  cardHolder: card.cardHolder,
                  accountNumber: card.accountNumber,
                  cvv: card.cvv,
                  expiryDate: card.expiryDate,
                  isDefault: card.isDefault,
                  height: 160, // Giảm chiều cao cho chế độ minimal
                  roundedCorners: true,
                  showMinimalInfo: true, // Chỉ hiển thị thông tin cơ bản
                );
              }

              return const CreditCardWidget(
                cardNumber: '9876687677658765',
                cardHolder: 'Đinh Trọng Phúc',
                accountNumber: '070987655453',
                height: 160, // Giảm chiều cao cho chế độ minimal
                roundedCorners: true,
                isDefault: true,
                showMinimalInfo: true, // Chỉ hiển thị thông tin cơ bản
              );
            },
          ),
        ],
      ),
    );
  }
}
