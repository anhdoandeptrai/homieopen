import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/card_repository.dart';
import 'card_event.dart';
import 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository _cardRepository;

  CardBloc({
    required CardRepository cardRepository,
  })  : _cardRepository = cardRepository,
        super(const CardInitial()) {
    // Register event handlers
    on<LoadCards>(_onLoadCards);
    on<LoadDefaultCard>(_onLoadDefaultCard);
    on<LoadCardById>(_onLoadCardById);
    on<AddCard>(_onAddCard);
    on<UpdateCard>(_onUpdateCard);
    on<DeleteCard>(_onDeleteCard);
    on<SetDefaultCard>(_onSetDefaultCard);
    on<ValidateCard>(_onValidateCard);
    on<CheckCardExists>(_onCheckCardExists);
    on<SelectCard>(_onSelectCard);
    on<ResetCardData>(_onResetCardData);
    on<ClearAllCards>(_onClearAllCards);
  }

  Future<void> _onLoadCards(
    LoadCards event,
    Emitter<CardState> emit,
  ) async {
    emit(const CardLoading());
    try {
      final cards = await _cardRepository.getAllCards();
      final defaultCard = await _cardRepository.getDefaultCard();

      if (cards.isEmpty) {
        emit(const CardsEmpty());
      } else {
        emit(CardsLoaded(
          cards: cards,
          defaultCard: defaultCard,
        ));
      }
    } catch (e) {
      emit(CardError(message: 'Không thể tải danh sách thẻ: ${e.toString()}'));
    }
  }

  Future<void> _onLoadDefaultCard(
    LoadDefaultCard event,
    Emitter<CardState> emit,
  ) async {
    emit(const CardLoading());
    try {
      final defaultCard = await _cardRepository.getDefaultCard();
      emit(DefaultCardLoaded(defaultCard));
    } catch (e) {
      emit(CardError(message: 'Không thể tải thẻ mặc định: ${e.toString()}'));
    }
  }

  Future<void> _onLoadCardById(
    LoadCardById event,
    Emitter<CardState> emit,
  ) async {
    emit(const CardLoading());
    try {
      final card = await _cardRepository.getCardById(event.cardId);
      emit(CardByIdLoaded(
        card: card,
        requestedId: event.cardId,
      ));
    } catch (e) {
      emit(CardError(message: 'Không thể tải thông tin thẻ: ${e.toString()}'));
    }
  }

  Future<void> _onAddCard(
    AddCard event,
    Emitter<CardState> emit,
  ) async {
    emit(const CardActionLoading('adding'));
    try {
      final success = await _cardRepository.addCard(event.card);
      if (success) {
        final updatedCards = await _cardRepository.getAllCards();
        emit(CardAdded(
          addedCard: event.card,
          updatedCards: updatedCards,
        ));
        emit(CardOperationSuccess(
          operation: 'added',
          message: 'Thẻ đã được thêm thành công',
        ));
      } else {
        emit(const CardActionFailed(
          action: 'adding',
          message: 'Không thể thêm thẻ',
        ));
      }
    } catch (e) {
      emit(CardActionFailed(
        action: 'adding',
        message: 'Lỗi khi thêm thẻ: ${e.toString()}',
      ));
    }
  }

  Future<void> _onUpdateCard(
    UpdateCard event,
    Emitter<CardState> emit,
  ) async {
    emit(const CardActionLoading('updating'));
    try {
      final success = await _cardRepository.updateCard(event.card);
      if (success) {
        final updatedCards = await _cardRepository.getAllCards();
        emit(CardUpdated(
          updatedCard: event.card,
          updatedCards: updatedCards,
        ));
        emit(CardOperationSuccess(
          operation: 'updated',
          message: 'Thẻ đã được cập nhật thành công',
        ));
      } else {
        emit(const CardActionFailed(
          action: 'updating',
          message: 'Không thể cập nhật thẻ',
        ));
      }
    } catch (e) {
      emit(CardActionFailed(
        action: 'updating',
        message: 'Lỗi khi cập nhật thẻ: ${e.toString()}',
      ));
    }
  }

  Future<void> _onDeleteCard(
    DeleteCard event,
    Emitter<CardState> emit,
  ) async {
    emit(const CardActionLoading('deleting'));
    try {
      final success = await _cardRepository.deleteCard(event.cardId);
      if (success) {
        final updatedCards = await _cardRepository.getAllCards();
        final newDefaultCard = await _cardRepository.getDefaultCard();

        emit(CardDeleted(
          deletedCardId: event.cardId,
          updatedCards: updatedCards,
          newDefaultCard: newDefaultCard,
        ));
        emit(CardOperationSuccess(
          operation: 'deleted',
          message: 'Thẻ đã được xóa thành công',
        ));
      } else {
        emit(const CardActionFailed(
          action: 'deleting',
          message: 'Không thể xóa thẻ',
        ));
      }
    } catch (e) {
      emit(CardActionFailed(
        action: 'deleting',
        message: 'Lỗi khi xóa thẻ: ${e.toString()}',
      ));
    }
  }

  Future<void> _onSetDefaultCard(
    SetDefaultCard event,
    Emitter<CardState> emit,
  ) async {
    emit(const CardActionLoading('setting_default'));
    try {
      final success = await _cardRepository.setDefaultCard(event.cardId);
      if (success) {
        final updatedCards = await _cardRepository.getAllCards();
        final newDefaultCard = await _cardRepository.getDefaultCard();

        if (newDefaultCard != null) {
          emit(DefaultCardSet(
            newDefaultCard: newDefaultCard,
            updatedCards: updatedCards,
          ));
          emit(CardOperationSuccess(
            operation: 'default_set',
            message: 'Thẻ mặc định đã được thiết lập',
          ));
        } else {
          emit(const CardActionFailed(
            action: 'setting_default',
            message: 'Không thể thiết lập thẻ mặc định',
          ));
        }
      } else {
        emit(const CardActionFailed(
          action: 'setting_default',
          message: 'Không thể thiết lập thẻ mặc định',
        ));
      }
    } catch (e) {
      emit(CardActionFailed(
        action: 'setting_default',
        message: 'Lỗi khi thiết lập thẻ mặc định: ${e.toString()}',
      ));
    }
  }

  Future<void> _onValidateCard(
    ValidateCard event,
    Emitter<CardState> emit,
  ) async {
    try {
      final validationResults = await _cardRepository.validateCard(
        cardNumber: event.cardNumber,
        cardHolder: event.cardHolder,
        expiryDate: event.expiryDate,
        cvv: event.cvv,
      );

      final isValid = validationResults.values.every((isValid) => isValid);

      emit(CardValidationResult(
        validationResults: validationResults,
        isValid: isValid,
      ));
    } catch (e) {
      emit(CardError(message: 'Lỗi khi xác thực thẻ: ${e.toString()}'));
    }
  }

  Future<void> _onCheckCardExists(
    CheckCardExists event,
    Emitter<CardState> emit,
  ) async {
    try {
      final exists = await _cardRepository.isCardNumberExists(event.cardNumber);
      emit(CardExistenceChecked(
        cardNumber: event.cardNumber,
        exists: exists,
      ));
    } catch (e) {
      emit(CardError(message: 'Lỗi khi kiểm tra thẻ: ${e.toString()}'));
    }
  }

  Future<void> _onSelectCard(
    SelectCard event,
    Emitter<CardState> emit,
  ) async {
    if (state is CardsLoaded) {
      final currentState = state as CardsLoaded;
      emit(currentState.copyWith(selectedCardId: event.cardId));
    }
  }

  Future<void> _onResetCardData(
    ResetCardData event,
    Emitter<CardState> emit,
  ) async {
    emit(const CardLoading());
    try {
      await _cardRepository.resetToSampleData();
      final cards = await _cardRepository.getAllCards();
      final defaultCard = await _cardRepository.getDefaultCard();

      emit(CardsLoaded(
        cards: cards,
        defaultCard: defaultCard,
      ));
      emit(CardOperationSuccess(
        operation: 'reset',
        message: 'Dữ liệu đã được khôi phục',
      ));
    } catch (e) {
      emit(CardError(message: 'Lỗi khi khôi phục dữ liệu: ${e.toString()}'));
    }
  }

  Future<void> _onClearAllCards(
    ClearAllCards event,
    Emitter<CardState> emit,
  ) async {
    emit(const CardLoading());
    try {
      await _cardRepository.clearAllCards();
      emit(const CardsEmpty());
      emit(CardOperationSuccess(
        operation: 'cleared',
        message: 'Tất cả thẻ đã được xóa',
      ));
    } catch (e) {
      emit(CardError(message: 'Lỗi khi xóa tất cả thẻ: ${e.toString()}'));
    }
  }

  // Helper methods
  String getCardType(String cardNumber) {
    return _cardRepository.getCardType(cardNumber);
  }
}
