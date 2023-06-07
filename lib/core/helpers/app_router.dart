import 'package:flutter/cupertino.dart';

class AppRouter {
  const AppRouter._();

  //TODO: close
  static back<T extends Object?>(BuildContext context, [T? result]) =>
      Navigator.pop(context, result);
  //TODO: push replacement
  static offNamed(BuildContext context, String routeName,
      {Object? arguments}) =>
      Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  //TODO: push
  static Future<T?> to<T extends Object?>(
      BuildContext context, String routeName,
      {Object? arguments}) =>
      Navigator.pushNamed(context, routeName, arguments: arguments);
  //TODO: can pop
  static bool canPop(BuildContext context) => Navigator.canPop(context);
  //TODO: back to first screen
  static backToFirstScreen(BuildContext context) {
    bool enablePop = true;
    while (enablePop) {
      if (canPop(context)) {
        back(context);
      } else {
        enablePop = false;
      }
    }
  }
}