import 'package:flutter/material.dart';

class NavigatorKeyService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BuildContext? get context => navigatorKey.currentContext;
}
