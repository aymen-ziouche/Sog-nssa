import 'package:flutter/material.dart';
import 'package:sognssa/utils/routes.dart';
import 'package:sognssa/views/pages/bottom_navbar.dart';
import 'package:sognssa/views/pages/landing_page.dart';
import 'package:sognssa/views/pages/auth_page.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.authPageRoute:
      return MaterialPageRoute(
          builder: (context) => const AuthPage(), settings: settings);
    case AppRoutes.bottomNavBarRoute:
      return MaterialPageRoute(
          builder: (context) => const BottonNavBar(), settings: settings);
    case AppRoutes.landingPageRoute:
    default:
      return MaterialPageRoute(
          builder: (context) => const LandingPage(), settings: settings);
  }
}
