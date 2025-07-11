import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import '../widgets/custom_switch.dart';
import '../bloc/card_bloc.dart';
import '../bloc/card_event.dart';
import '../bloc/card_state.dart';
import '../../models/credit_card_model.dart';
import '../../models/card_data_manager.dart';

class AddPaymentCardPage extends StatefulWidget {
  const AddPaymentCardPage({super.key});

  @override
  State<AddPaymentCardPage> createState() => _AddPaymentCardPageState();
}

class _AddPaymentCardPageState extends State<AddPaymentCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _bankController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _cvvController = TextEditingController();
  final _expiryController = TextEditingController();

  bool _isDefaultCard = false;
  String _selectedBank = 'Chọn ngân hàng';

  @override
  void dispose() {
    _bankController.dispose();
    _cardNumberController.dispose();
    _accountNumberController.dispose();
    _cardHolderController.dispose();
    _cvvController.dispose();
    _expiryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardBloc, CardState>(
      listener: (context, state) {
        if (state is CardAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Thẻ đã được thêm thành công'),
              backgroundColor: AppColor.turquoise500,
            ),
          );
          Navigator.pop(context);
        } else if (state is CardActionFailed && state.action == 'adding') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.oslo950,
        appBar: AppBar(
          backgroundColor: AppColor.oslo950,
          foregroundColor: Colors.white,
          title: const Text(
            'Thêm thẻ thanh toán',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: AppColor.turquoise500),
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
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDropdownField(
                                label: 'Chọn ngân hàng',
                                value: _selectedBank,
                                onTap: () => _showBankSelection(),
                                hasDropdown: true,
                              ),
                              // ...existing code...
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _cardNumberController,
                                label: 'Số thẻ',
                                hintText: '',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CardNumberInputFormatter(),
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập số thẻ';
                                  }
                                  if (value.replaceAll(' ', '').length < 16) {
                                    return 'Số thẻ phải có 16 chữ số';
                                  }
                                  return null;
                                },
                              ),
                              // ...existing code...
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _accountNumberController,
                                label: 'Số tài khoản',
                                hintText: '',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập số tài khoản';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _cardHolderController,
                                label: 'Tên chủ thẻ',
                                hintText: '',
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập tên chủ thẻ';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _cvvController,
                                label: 'CVV',
                                hintText: '',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập CVV';
                                  }
                                  if (value.length != 3) {
                                    return 'CVV phải có 3 chữ số';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _expiryController,
                                label: 'Thời hạn (MM/YY)',
                                hintText: '',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  ExpiryDateInputFormatter(),
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập thời hạn';
                                  }
                                  if (!RegExp(r'^\d{2}/\d{2}$')
                                      .hasMatch(value)) {
                                    return 'Định dạng: MM/YY';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          children: [
                            const Text(
                              'Đặt làm thẻ mặc định',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            CustomSwitch(
                              value: _isDefaultCard,
                              onChanged: (value) {
                                setState(() {
                                  _isDefaultCard = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: BlocBuilder<CardBloc, CardState>(
                          builder: (context, state) {
                            final isLoading = state is CardActionLoading &&
                                state.action == 'adding';

                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isLoading ? null : _addCard,
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
                                child: isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        'Thêm thẻ',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      validator: validator,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 16,
        ),
        hintText: hintText.isEmpty ? null : hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        filled: true,
        fillColor: Colors.black.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColor.turquoise500,
            width: 1,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required VoidCallback onTap,
    bool hasDropdown = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: value == 'Chọn ngân hàng'
                      ? Colors.grey.shade500
                      : Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            if (hasDropdown)
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey.shade500,
              ),
          ],
        ),
      ),
    );
  }

  void _showBankSelection() {
    final banks = [
      'Vietcombank',
      'BIDV',
      'VietinBank',
      'Agribank',
      'Techcombank',
      'MB Bank',
      'ACB',
      'VPBank',
      'Sacombank',
      'SHB',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.oslo950,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.8,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Chọn ngân hàng',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: banks.length,
                  itemBuilder: (context, index) {
                    final bank = banks[index];
                    return ListTile(
                      title: Text(
                        bank,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedBank = bank;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addCard() {
    if (_formKey.currentState!.validate()) {
      if (_selectedBank == 'Chọn ngân hàng') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng chọn ngân hàng'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Create new card model
      final cardDataManager = CardDataManager();
      final newCard = CreditCardModel(
        id: cardDataManager.generateCardId(),
        cardNumber: _cardNumberController.text.replaceAll(' ', ''),
        cardHolder: _cardHolderController.text.trim(),
        accountNumber: _accountNumberController.text.trim(),
        cvv: _cvvController.text.trim(),
        expiryDate: _expiryController.text.trim(),
        cardType: CardDataManager.detectCardType(_cardNumberController.text),
        isDefault: _isDefaultCard,
        createdAt: DateTime.now(),
      );

      // Add card using BLoC
      context.read<CardBloc>().add(AddCard(newCard));
    }
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.length <= 2) {
      return newValue;
    }

    if (text.length <= 4) {
      final month = text.substring(0, 2);
      final year = text.substring(2);
      return TextEditingValue(
        text: '$month/$year',
        selection: TextSelection.collapsed(offset: '$month/$year'.length),
      );
    }

    // Limit to MM/YY format (5 characters total)
    if (text.length > 5) {
      return oldValue;
    }

    return newValue;
  }
}
