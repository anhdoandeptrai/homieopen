import 'package:flutter/material.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import '../widgets/credit_card_widget.dart';

class ChangePaymentCardPage extends StatefulWidget {
  const ChangePaymentCardPage({super.key});

  @override
  State<ChangePaymentCardPage> createState() => _ChangePaymentCardPageState();
}

class _ChangePaymentCardPageState extends State<ChangePaymentCardPage> {
  int selectedCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.oslo950,
      appBar: AppBar(
        backgroundColor: AppColor.oslo950,
        foregroundColor: Colors.white,
        title: const Text(
          'Đổi thẻ thanh toán',
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
              padding: const EdgeInsets.symmetric(
                  vertical: 16), // Chỉ padding trên dưới để card tràn viền
              child: Column(
                children: [
                  _buildCard(
                    index: 0,
                    cardNumber: '9876687677658765',
                    cardHolder: 'Đinh Trọng Phúc',
                    accountNumber: '070987655453',
                    cvv: '489',
                    expiryDate: '06/2028',
                    isDefault: true,
                  ),
                  const SizedBox(height: 20),
                  _buildCard(
                    index: 1,
                    cardNumber: '9876687677658765',
                    cardHolder: 'Đinh Trọng Phúc',
                    accountNumber: '070987655453',
                    cvv: '489',
                    expiryDate: '06/2028',
                    isDefault: false,
                  ),
                ],
              ),
            ),
          ),
          _buildAddCardButton(),
        ],
      ),
    );
  }

  Widget _buildCard({
    required int index,
    required String cardNumber,
    required String cardHolder,
    required String accountNumber,
    required String cvv,
    required String expiryDate,
    required bool isDefault,
  }) {
    final isSelected = selectedCardIndex == index;

    return Stack(
      children: [
        CreditCardWidget(
          cardNumber: cardNumber,
          cardHolder: cardHolder,
          accountNumber: accountNumber,
          cvv: cvv,
          expiryDate: expiryDate,
          isDefault: isDefault,
          height: 240,
          roundedCorners: false, // Không bo tròn để tràn viền
          showEditButton: true,
          showSelection: true,
          isSelected: isSelected,
          showMinimalInfo: false,
          onTap: () => _selectCard(index),
          onEdit: () => _editCard(),
        ),
      ],
    );
  }

  Widget _buildAddCardButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/add-payment-card');
        },
        child: Container(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: AppColor.turquoise500,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Thêm thẻ thanh toán',
                style: TextStyle(
                  color: AppColor.turquoise500,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectCard(int index) {
    setState(() {
      selectedCardIndex = index;
    });
  }

  void _editCard() {
    Navigator.pushNamed(context, '/add-payment-card');
  }
}
