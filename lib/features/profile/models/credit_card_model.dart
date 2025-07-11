class CreditCardModel {
  final String id;
  final String cardNumber;
  final String cardHolder;
  final String accountNumber;
  final String? cvv;
  final String? expiryDate;
  final String cardType; // 'visa', 'mastercard', 'amex', etc.
  final bool isDefault;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const CreditCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolder,
    required this.accountNumber,
    this.cvv,
    this.expiryDate,
    required this.cardType,
    this.isDefault = false,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });

  // Masked card number for display (e.g., "**** **** **** 1234")
  String get maskedCardNumber {
    if (cardNumber.length < 4) return cardNumber;
    final lastFour = cardNumber.substring(cardNumber.length - 4);
    final masked = '*' * (cardNumber.length - 4);
    return '${masked.substring(0, 4)} ${masked.substring(4, 8)} ${masked.substring(8, 12)} $lastFour';
  }

  // Formatted card number for display (e.g., "1234 5678 9012 3456")
  String get formattedCardNumber {
    return cardNumber
        .replaceAllMapped(
          RegExp(r'(.{4})'),
          (match) => '${match.group(1)} ',
        )
        .trim();
  }

  // Check if card is expired
  bool get isExpired {
    if (expiryDate == null) return false;
    try {
      final parts = expiryDate!.split('/');
      if (parts.length != 2) return false;

      final month = int.parse(parts[0]);
      final year = int.parse('20${parts[1]}'); // Assuming YY format

      final expiry = DateTime(year, month + 1, 0); // Last day of expiry month
      return DateTime.now().isAfter(expiry);
    } catch (e) {
      return false;
    }
  }

  CreditCardModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolder,
    String? accountNumber,
    String? cvv,
    String? expiryDate,
    String? cardType,
    bool? isDefault,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CreditCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolder: cardHolder ?? this.cardHolder,
      accountNumber: accountNumber ?? this.accountNumber,
      cvv: cvv ?? this.cvv,
      expiryDate: expiryDate ?? this.expiryDate,
      cardType: cardType ?? this.cardType,
      isDefault: isDefault ?? this.isDefault,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'cardHolder': cardHolder,
      'accountNumber': accountNumber,
      'cvv': cvv,
      'expiryDate': expiryDate,
      'cardType': cardType,
      'isDefault': isDefault,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory CreditCardModel.fromJson(Map<String, dynamic> json) {
    return CreditCardModel(
      id: json['id'],
      cardNumber: json['cardNumber'],
      cardHolder: json['cardHolder'],
      accountNumber: json['accountNumber'],
      cvv: json['cvv'],
      expiryDate: json['expiryDate'],
      cardType: json['cardType'],
      isDefault: json['isDefault'] ?? false,
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreditCardModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CreditCardModel(id: $id, cardHolder: $cardHolder, maskedNumber: $maskedCardNumber, isDefault: $isDefault)';
  }
}
