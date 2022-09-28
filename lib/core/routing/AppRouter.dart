import 'package:currency_converter/core/routing/routes.dart';
import 'package:currency_converter/features/historical_data/presentation/pages/latest_page.dart';
import 'package:currency_converter/features/home/presentation/pages/home_page.dart';
import 'package:currency_converter/main.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    Map? arguments =
    (settings.arguments is String ? {} : settings.arguments) as Map?;
    arguments ??= {};

    switch (settings.name) {
      case AppRoutes.main:
        {
          return MaterialPageRoute(
              settings: settings, builder: (_) => MainPage());
        }

      case AppRoutes.supported:
        {
          return MaterialPageRoute(
              settings: settings, builder: (_) => SupportedCurrenciesPage());
        }
      case AppRoutes.latest:
        {
          return MaterialPageRoute(
              settings: settings, builder: (_) => LatestConversionsPage(currency: arguments!['currency']));
        }

      default:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}