import 'credit_card_model.dart';

class CardDataManager {
  static final CardDataManager _instance = CardDataManager._internal();
  factory CardDataManager() => _instance;
  CardDataManager._internal();

  // Sample data for testing
  final List<CreditCardModel> _sampleCards = [
    CreditCardModel(
      id: '1',
      cardNumber: '9876687677658765',
      cardHolder: 'Đinh Trọng Phúc',
      accountNumber: '070987655453',
      cvv: '123',
      expiryDate: '12/26',
      cardType: 'visa',
      isDefault: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    CreditCardModel(
      id: '2',
      cardNumber: '1234567890123456',
      cardHolder: 'Nguyễn Văn A',
      accountNumber: '080123456789',
      cvv: '456',
      expiryDate: '06/27',
      cardType: 'mastercard',
      isDefault: false,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    CreditCardModel(
      id: '3',
      cardNumber: '5555444433332222',
      cardHolder: 'Trần Thị B',
      accountNumber: '090987654321',
      cvv: '789',
      expiryDate: '03/25',
      cardType: 'visa',
      isDefault: false,
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
    ),
  ];

  List<CreditCardModel> get sampleCards => List.unmodifiable(_sampleCards);

  // Get default card
  CreditCardModel? get defaultCard {
    try {
      return _sampleCards.firstWhere((card) => card.isDefault && card.isActive);
    } catch (e) {
      return _sampleCards.isNotEmpty ? _sampleCards.first : null;
    }
  }

  // Get active cards
  List<CreditCardModel> get activeCards {
    return _sampleCards.where((card) => card.isActive).toList();
  }

  // Get card by ID
  CreditCardModel? getCardById(String id) {
    try {
      return _sampleCards.firstWhere((card) => card.id == id);
    } catch (e) {
      return null;
    }
  }

  // Add new card
  void addCard(CreditCardModel card) {
    // If this is the first card or marked as default, make it default
    if (_sampleCards.isEmpty || card.isDefault) {
      // Remove default status from other cards
      for (int i = 0; i < _sampleCards.length; i++) {
        if (_sampleCards[i].isDefault) {
          _sampleCards[i] = _sampleCards[i].copyWith(isDefault: false);
        }
      }
    }
    _sampleCards.add(card);
  }

  // Update card
  void updateCard(CreditCardModel updatedCard) {
    final index = _sampleCards.indexWhere((card) => card.id == updatedCard.id);
    if (index != -1) {
      // If setting as default, remove default from others
      if (updatedCard.isDefault) {
        for (int i = 0; i < _sampleCards.length; i++) {
          if (i != index && _sampleCards[i].isDefault) {
            _sampleCards[i] = _sampleCards[i].copyWith(isDefault: false);
          }
        }
      }
      _sampleCards[index] = updatedCard.copyWith(updatedAt: DateTime.now());
    }
  }

  // Delete card
  bool deleteCard(String id) {
    final initialLength = _sampleCards.length;
    _sampleCards.removeWhere((card) => card.id == id);

    // If deleted card was default and there are other cards, make first one default
    if (_sampleCards.isNotEmpty &&
        !_sampleCards.any((card) => card.isDefault)) {
      _sampleCards[0] = _sampleCards[0].copyWith(isDefault: true);
    }

    return initialLength != _sampleCards.length;
  }

  // Set default card
  void setDefaultCard(String id) {
    for (int i = 0; i < _sampleCards.length; i++) {
      _sampleCards[i] = _sampleCards[i].copyWith(
        isDefault: _sampleCards[i].id == id,
        updatedAt: DateTime.now(),
      );
    }
  }

  // Validate card number using Luhn algorithm
  static bool validateCardNumber(String cardNumber) {
    final cleanNumber = cardNumber.replaceAll(RegExp(r'\D'), '');
    if (cleanNumber.length < 13 || cleanNumber.length > 19) {
      return false;
    }

    int sum = 0;
    bool isEven = false;

    for (int i = cleanNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cleanNumber[i]);

      if (isEven) {
        digit *= 2;
        if (digit > 9) {
          digit = digit ~/ 10 + digit % 10;
        }
      }

      sum += digit;
      isEven = !isEven;
    }

    return sum % 10 == 0;
  }

  // Detect card type based on card number
  static String detectCardType(String cardNumber) {
    final cleanNumber = cardNumber.replaceAll(RegExp(r'\D'), '');

    if (cleanNumber.startsWith('4')) {
      return 'visa';
    } else if (cleanNumber.startsWith(RegExp(r'^5[1-5]')) ||
        cleanNumber.startsWith(RegExp(r'^2[2-7]'))) {
      return 'mastercard';
    } else if (cleanNumber.startsWith(RegExp(r'^3[47]'))) {
      return 'amex';
    } else if (cleanNumber.startsWith('6011') ||
        cleanNumber.startsWith(RegExp(r'^65'))) {
      return 'discover';
    } else {
      return 'unknown';
    }
  }

  // Generate unique ID for new card
  String generateCardId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  // Clear all cards (for testing purposes)
  void clearAllCards() {
    _sampleCards.clear();
  }

  // Reset to sample data
  void resetToSampleData() {
    clearAllCards();
    _sampleCards.addAll([
      CreditCardModel(
        id: '1',
        cardNumber: '9876687677658765',
        cardHolder: 'Đinh Trọng Phúc',
        accountNumber: '070987655453',
        cvv: '123',
        expiryDate: '12/26',
        cardType: 'visa',
        isDefault: true,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      CreditCardModel(
        id: '2',
        cardNumber: '1234567890123456',
        cardHolder: 'Nguyễn Văn A',
        accountNumber: '080123456789',
        cvv: '456',
        expiryDate: '06/27',
        cardType: 'mastercard',
        isDefault: false,
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      CreditCardModel(
        id: '3',
        cardNumber: '5555444433332222',
        cardHolder: 'Trần Thị B',
        accountNumber: '090987654321',
        cvv: '789',
        expiryDate: '03/25',
        cardType: 'visa',
        isDefault: false,
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
      ),
    ]);
  }
}
