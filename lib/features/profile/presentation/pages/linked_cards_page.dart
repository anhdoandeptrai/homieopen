import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import '../widgets/credit_card_widget.dart';
import '../bloc/card_bloc.dart';
import '../bloc/card_event.dart';
import '../bloc/card_state.dart';
import '../../models/credit_card_model.dart';

class LinkedCardsPage extends StatefulWidget {
  const LinkedCardsPage({super.key});

  @override
  State<LinkedCardsPage> createState() => _LinkedCardsPageState();
}

class _LinkedCardsPageState extends State<LinkedCardsPage> {
  @override
  void initState() {
    super.initState();
    // Load all cards when page initializes
    context.read<CardBloc>().add(const LoadCards());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardBloc, CardState>(
      listener: (context, state) {
        if (state is CardDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đã xóa thẻ thành công'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is DefaultCardSet) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đã đặt làm thẻ mặc định'),
              backgroundColor: AppColor.turquoise500,
            ),
          );
        } else if (state is CardActionFailed) {
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
            'Liên kết thẻ',
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
        body: BlocBuilder<CardBloc, CardState>(
          builder: (context, state) {
            if (state is CardLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColor.turquoise500,
                ),
              );
            }

            if (state is CardsLoaded) {
              final cards = state.cards;

              if (cards.isEmpty) {
                return _buildEmptyState();
              }

              return _buildCardsList(cards);
            }

            if (state is CardActionFailed) {
              return _buildErrorState(state.message);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildCardsList(List<CreditCardModel> cards) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          // Cards list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cards.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final card = cards[index];

              return CreditCardWidget(
                cardNumber: card.cardNumber,
                cardHolder: card.cardHolder,
                accountNumber: card.accountNumber,
                cvv: card.cvv ?? '',
                expiryDate: card.expiryDate ?? '',
                isDefault: card.isDefault,
                showEditButton: true,
                roundedCorners: false, // Không bo tròn để tràn viền
                height: 240,
                onEdit: () => _showEditCardOptions(card),
              );
            },
          ),

          const SizedBox(height: 32),

          // Add new card button with improved styling
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/add-payment-card');
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: AppColor.oslo900.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColor.turquoise500.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: AppColor.turquoise500,
                      size: 24,
                    ),
                    SizedBox(width: 12),
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
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.credit_card_off,
            size: 80,
            color: Colors.grey.shade600,
          ),
          const SizedBox(height: 16),
          Text(
            'Chưa có thẻ nào',
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Thêm thẻ đầu tiên để bắt đầu thanh toán',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/add-payment-card');
            },
            icon: const Icon(Icons.add),
            label: const Text('Thêm thẻ mới'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.turquoise500,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Đã xảy ra lỗi',
            style: TextStyle(
              color: Colors.red.shade400,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<CardBloc>().add(const LoadCards());
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Thử lại'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.turquoise500,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditCardOptions(CreditCardModel card) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.oslo950,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Chỉnh sửa thẻ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(
                Icons.edit_outlined,
                color: AppColor.turquoise500,
              ),
              title: const Text(
                'Chỉnh sửa thông tin',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                _editCard(card);
              },
            ),
            if (!card.isDefault)
              ListTile(
                leading: const Icon(
                  Icons.star_outline,
                  color: AppColor.turquoise500,
                ),
                title: const Text(
                  'Đặt làm thẻ mặc định',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _setAsDefaultCard(card.id);
                },
              ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              title: const Text(
                'Xóa thẻ',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                _deleteCard(card);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editCard(CreditCardModel card) {
    // Navigate to edit card page with card data
    Navigator.pushNamed(
      context,
      '/add-payment-card',
      arguments: card, // Pass card data for editing
    );
  }

  void _setAsDefaultCard(String cardId) {
    // Set as default card using BLoC
    context.read<CardBloc>().add(SetDefaultCard(cardId));
  }

  void _deleteCard(CreditCardModel card) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColor.oslo900,
        title: const Text(
          'Xác nhận xóa',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bạn có chắc chắn muốn xóa thẻ này không?',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              'Thẻ: ${card.maskedCardNumber}',
              style: const TextStyle(
                color: AppColor.turquoise500,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (card.isDefault)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  '⚠️ Đây là thẻ mặc định. Bạn sẽ cần chọn thẻ mặc định mới.',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Hủy',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          BlocBuilder<CardBloc, CardState>(
            builder: (context, state) {
              final isDeleting =
                  state is CardActionLoading && state.action == 'deleting';

              return TextButton(
                onPressed: isDeleting
                    ? null
                    : () {
                        Navigator.pop(context);
                        context.read<CardBloc>().add(DeleteCard(card.id));
                      },
                child: isDeleting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      )
                    : const Text(
                        'Xóa',
                        style: TextStyle(color: Colors.red),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
