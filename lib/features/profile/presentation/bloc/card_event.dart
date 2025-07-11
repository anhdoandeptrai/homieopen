import 'package:equatable/equatable.dart';
import '../../models/credit_card_model.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object?> get props => [];
}

// Load all cards
class LoadCards extends CardEvent {
  const LoadCards();
}

// Load default card
class LoadDefaultCard extends CardEvent {
  const LoadDefaultCard();
}

// Load specific card by ID
class LoadCardById extends CardEvent {
  final String cardId;

  const LoadCardById(this.cardId);

  @override
  List<Object?> get props => [cardId];
}

// Add new card
class AddCard extends CardEvent {
  final CreditCardModel card;

  const AddCard(this.card);

  @override
  List<Object?> get props => [card];
}

// Update existing card
class UpdateCard extends CardEvent {
  final CreditCardModel card;

  const UpdateCard(this.card);

  @override
  List<Object?> get props => [card];
}

// Delete card
class DeleteCard extends CardEvent {
  final String cardId;

  const DeleteCard(this.cardId);

  @override
  List<Object?> get props => [cardId];
}

// Set default card
class SetDefaultCard extends CardEvent {
  final String cardId;

  const SetDefaultCard(this.cardId);

  @override
  List<Object?> get props => [cardId];
}

// Validate card details
class ValidateCard extends CardEvent {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cvv;

  const ValidateCard({
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cvv,
  });

  @override
  List<Object?> get props => [cardNumber, cardHolder, expiryDate, cvv];
}

// Check if card number exists
class CheckCardExists extends CardEvent {
  final String cardNumber;

  const CheckCardExists(this.cardNumber);

  @override
  List<Object?> get props => [cardNumber];
}

// Reset to sample data (for testing)
class ResetCardData extends CardEvent {
  const ResetCardData();
}

// Clear all cards (for testing)
class ClearAllCards extends CardEvent {
  const ClearAllCards();
}

// Select card (for UI state)
class SelectCard extends CardEvent {
  final String? cardId;

  const SelectCard(this.cardId);

  @override
  List<Object?> get props => [cardId];
}
