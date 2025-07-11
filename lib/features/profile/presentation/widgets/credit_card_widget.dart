import 'package:app_homieopen_3047/core/assets/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';

class CurvedBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * 0.25, 0);

    final controlPoint1 = Offset(size.width * 0.5, size.height * 0.6);
    final controlPoint2 = Offset(size.width * 0.9, size.height * 0.015);
    final endPoint = Offset(size.width, size.height * 0.7);

    path.cubicTo(
      controlPoint1.dx,
      controlPoint1.dy,
      controlPoint2.dx,
      controlPoint2.dy,
      endPoint.dx,
      endPoint.dy,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          AppColor.turquoise500.withOpacity(0.3),
          AppColor.turquoise700.withOpacity(0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CreditCardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String accountNumber;
  final String? cvv;
  final String? expiryDate;
  final bool isDefault;
  final bool isSelected;
  final bool showSelection;
  final bool showEditButton;
  final bool roundedCorners;
  final bool
      showMinimalInfo; // Chỉ hiển thị thông tin cơ bản cho trang thanh toán
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final double height;

  const CreditCardWidget({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.accountNumber,
    this.cvv,
    this.expiryDate,
    this.isDefault = false,
    this.isSelected = false,
    this.showSelection = false,
    this.showEditButton = false,
    this.roundedCorners = false,
    this.showMinimalInfo = false, // Mặc định hiển thị đầy đủ thông tin
    this.onTap,
    this.onEdit,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height,
        decoration: BoxDecoration(
          borderRadius: roundedCorners ? BorderRadius.circular(16) : null,
          boxShadow: isSelected && showSelection
              ? [
                  BoxShadow(
                    color: AppColor.turquoise500.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: roundedCorners
            ? ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _buildCardContent(),
              )
            : _buildCardContent(),
      ),
    );
  }

  Widget _buildCardContent() {
    return Stack(
      children: [
        // Nền vuông bo 4 góc
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        // Main card background
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isSelected && showSelection
                  ? [
                      AppColor.turquoise600,
                      AppColor.turquoise800,
                    ]
                  : [
                      AppColor.turquoise700,
                      AppColor.turquoise900,
                    ],
            ),
            borderRadius: roundedCorners ? BorderRadius.circular(16) : null,
          ),
        ),
        CustomPaint(
          painter: CurvedBackgroundPainter(),
          size: Size(double.infinity, height),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    AppVector.visa,
                    height: 40,
                    width: 60,
                  ),
                  if (showSelection)
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? AppColor.turquoise500
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                _formatCardNumber(cardNumber),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                cardHolder,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 2,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Số tài khoản: $accountNumber',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (!showMinimalInfo) ...[
                if (expiryDate != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Ngày hết hạn: $expiryDate',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
                if (cvv != null && cvv!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    'CVV: $cvv',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
                if (isDefault) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Mặc định',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),

        // Nút "Chỉnh sửa" ở góc dưới phải
        if (showEditButton)
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: onEdit,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColor.turquoise500,
                    width: 1.5,
                  ),
                ),
                child: const Text(
                  'Chỉnh sửa',
                  style: TextStyle(
                    color: AppColor.turquoise500,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _formatCardNumber(String cardNumber) {
    final cleanNumber = cardNumber.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < cleanNumber.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(cleanNumber[i]);
    }

    return buffer.toString();
  }
}
