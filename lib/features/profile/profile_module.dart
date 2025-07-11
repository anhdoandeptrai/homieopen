import 'package:flutter/material.dart';
import 'presentation/pages/profile_page.dart';
import 'presentation/pages/guest_profile_page.dart';
import 'presentation/pages/membership_packages_page.dart';
import 'presentation/pages/membership_detail_page.dart';
import 'presentation/pages/payment_page.dart';
import 'presentation/pages/change_payment_card_page.dart';
import 'presentation/pages/linked_cards_page.dart';
import 'presentation/pages/add_payment_card_page.dart';

class ProfileModule {
  static Map<String, WidgetBuilder> routes() {
    return {
      '/profile': (context) => const ProfilePage(),
      '/guest-profile': (context) => const GuestProfilePage(),
      '/membership-packages': (context) => const MembershipPackagesPage(),
      '/membership-detail': (context) => const MembershipDetailPage(),
      '/payment': (context) => const PaymentPage(),
      '/change-payment-card': (context) => const ChangePaymentCardPage(),
      '/linked-cards': (context) => const LinkedCardsPage(),
      '/add-payment-card': (context) => const AddPaymentCardPage(),
    };
  }
}
