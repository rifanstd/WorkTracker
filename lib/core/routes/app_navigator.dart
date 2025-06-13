import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigator {
  AppNavigator._();

  static void goTo(BuildContext context, String path) => context.go(path);
  static void pushTo(BuildContext context, String path) => context.push(path);
  static void pop(BuildContext context) => context.pop();
}
