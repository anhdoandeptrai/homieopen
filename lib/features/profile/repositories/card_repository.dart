import '../models/credit_card_model.dart';
import '../models/card_data_manager.dart';

class CardRepository {
  final CardDataManager _cardDataManager = CardDataManager();

  // Get all cards
  Future<List<CreditCardModel>> getAllCards() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // Simulate network delay
    return _cardDataManager.activeCards;
  }

  // Get default card
  Future<CreditCardModel?> getDefaultCard() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _cardDataManager.defaultCard;
  }

  // Get card by ID
  Future<CreditCardModel?> getCardById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _cardDataManager.getCardById(id);
  }

  // Add new card
  Future<bool> addCard(CreditCardModel card) async {
    await Future.delayed(
        const Duration(milliseconds: 800)); // Simulate API call
    try {
      _cardDataManager.addCard(card);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Update existing card
  Future<bool> updateCard(CreditCardModel card) async {
    await Future.delayed(const Duration(milliseconds: 600));
    try {
      _cardDataManager.updateCard(card);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Delete card
  Future<bool> deleteCard(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _cardDataManager.deleteCard(id);
  }

  // Set default card
  Future<bool> setDefaultCard(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    try {
      _cardDataManager.setDefaultCard(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Validate card details
  Future<Map<String, bool>> validateCard({
    required String cardNumber,
    required String cardHolder,
    required String expiryDate,
    required String cvv,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return {
      'cardNumber': CardDataManager.validateCardNumber(cardNumber),
      'cardHolder': cardHolder.trim().isNotEmpty && cardHolder.length >= 2,
      'expiryDate': _validateExpiryDate(expiryDate),
      'cvv': _validateCVV(cvv),
    };
  }

  // Check if card number already exists
  Future<bool> isCardNumberExists(String cardNumber) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final cards = _cardDataManager.sampleCards;
    return cards
        .any((card) => card.cardNumber == cardNumber.replaceAll(' ', ''));
  }

  // Get card type
  String getCardType(String cardNumber) {
    return CardDataManager.detectCardType(cardNumber);
  }

  // Private helper methods
  bool _validateExpiryDate(String expiryDate) {
    if (expiryDate.length != 5 || !expiryDate.contains('/')) {
      return false;
    }

    try {
      final parts = expiryDate.split('/');
      if (parts.length != 2) return false;

      final month = int.parse(parts[0]);
      final year = int.parse('20${parts[1]}');

      if (month < 1 || month > 12) return false;

      final expiry = DateTime(year, month + 1, 0);
      return DateTime.now().isBefore(expiry);
    } catch (e) {
      return false;
    }
  }

  bool _validateCVV(String cvv) {
    return cvv.length >= 3 && cvv.length <= 4 && RegExp(r'^\d+$').hasMatch(cvv);
  }

  // For testing purposes
  Future<void> resetToSampleData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _cardDataManager.resetToSampleData();
  }

  Future<void> clearAllCards() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _cardDataManager.clearAllCards();
  }
}
