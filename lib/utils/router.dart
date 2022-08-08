import 'package:flutter/material.dart';
import 'package:sognssa/models/product.dart';
import 'package:sognssa/utils/routes.dart';
import 'package:sognssa/views/pages/bottom_navbar.dart';
import 'package:sognssa/views/pages/landing_page.dart';
import 'package:sognssa/views/pages/auth_page.dart';
import 'package:sognssa/views/pages/product_details.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginPageRoute:
      return MaterialPageRoute(
        builder: (_) => const AuthPage(),
        settings: settings,
      );
    case AppRoutes.bottomNavBarRoute:
      return MaterialPageRoute(
        builder: (_) => const BottonNavBar(),
        settings: settings,
      );
    case AppRoutes.productDetailsRoute:
      final product = settings.arguments as Product;
      return MaterialPageRoute(
        builder: (_) => ProductDetails(product: product),
        settings: settings,
      );
    case AppRoutes.landingPageRoute:
    default:
      return MaterialPageRoute(
        builder: (_) => const LandingPage(),
        settings: settings,
      );
  }
}