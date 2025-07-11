import 'package:equatable/equatable.dart';
import '../../models/credit_card_model.dart';

abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object?> get props => [];
}

// Initial state
class CardInitial extends CardState {
  const CardInitial();
}

// Loading states
class CardLoading extends CardState {
  const CardLoading();
}

class CardActionLoading extends CardState {
  final String action; // 'adding', 'updating', 'deleting', 'setting_default'

  const CardActionLoading(this.action);

  @override
  List<Object?> get props => [action];
}

// Success states
class CardsLoaded extends CardState {
  final List<CreditCardModel> cards;
  final CreditCardModel? defaultCard;
  final String? selectedCardId;

  const CardsLoaded({
    required this.cards,
    this.defaultCard,
    this.selectedCardId,
  });

  @override
  List<Object?> get props => [cards, defaultCard, selectedCardId];

  CardsLoaded copyWith({
    List<CreditCardModel>? cards,
    CreditCardModel? defaultCard,
    String? selectedCardId,
    bool clearSelectedCard = false,
  }) {
    return CardsLoaded(
      cards: cards ?? this.cards,
      defaultCard: defaultCard ?? this.defaultCard,
      selectedCardId:
          clearSelectedCard ? null : (selectedCardId ?? this.selectedCardId),
    );
  }
}

class DefaultCardLoaded extends CardState {
  final CreditCardModel? defaultCard;

  const DefaultCardLoaded(this.defaultCard);

  @override
  List<Object?> get props => [defaultCard];
}

class CardByIdLoaded extends CardState {
  final CreditCardModel? card;
  final String requestedId;

  const CardByIdLoaded({
    required this.card,
    required this.requestedId,
  });

  @override
  List<Object?> get props => [card, requestedId];
}

// Action success states
class CardAdded extends CardState {
  final CreditCardModel addedCard;
  final List<CreditCardModel> updatedCards;

  const CardAdded({
    required this.addedCard,
    required this.updatedCards,
  });

  @override
  List<Object?> get props => [addedCard, updatedCards];
}

class CardUpdated extends CardState {
  final CreditCardModel updatedCard;
  final List<CreditCardModel> updatedCards;

  const CardUpdated({
    required this.updatedCard,
    required this.updatedCards,
  });

  @override
  List<Object?> get props => [updatedCard, updatedCards];
}

class CardDeleted extends CardState {
  final String deletedCardId;
  final List<CreditCardModel> updatedCards;
  final CreditCardModel? newDefaultCard;

  const CardDeleted({
    required this.deletedCardId,
    required this.updatedCards,
    this.newDefaultCard,
  });

  @override
  List<Object?> get props => [deletedCardId, updatedCards, newDefaultCard];
}

class DefaultCardSet extends CardState {
  final CreditCardModel newDefaultCard;
  final List<CreditCardModel> updatedCards;

  const DefaultCardSet({
    required this.newDefaultCard,
    required this.updatedCards,
  });

  @override
  List<Object?> get props => [newDefaultCard, updatedCards];
}

// Validation states
class CardValidationResult extends CardState {
  final Map<String, bool> validationResults;
  final bool isValid;

  const CardValidationResult({
    required this.validationResults,
    required this.isValid,
  });

  @override
  List<Object?> get props => [validationResults, isValid];
}

class CardExistenceChecked extends CardState {
  final String cardNumber;
  final bool exists;

  const CardExistenceChecked({
    required this.cardNumber,
    required this.exists,
  });

  @override
  List<Object?> get props => [cardNumber, exists];
}

// Error states
class CardError extends CardState {
  final String message;
  final String? errorCode;

  const CardError({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}

class CardActionFailed extends CardState {
  final String action;
  final String message;
  final String? errorCode;

  const CardActionFailed({
    required this.action,
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [action, message, errorCode];
}

// Empty state
class CardsEmpty extends CardState {
  const CardsEmpty();
}

// Operation success confirmations
class CardOperationSuccess extends CardState {
  final String operation; // 'added', 'updated', 'deleted', 'default_set'
  final String message;

  const CardOperationSuccess({
    required this.operation,
    required this.message,
  });

  @override
  List<Object?> get props => [operation, message];
}
