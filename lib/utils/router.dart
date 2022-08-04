import 'package:flutter/material.dart';
import 'package:sognssa/utils/routes.dart';
import 'package:sognssa/views/pages/landing_page.dart';
import 'package:sognssa/views/pages/auth_page.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.authPageRoute:
      return MaterialPageRoute(builder: (context) => const AuthPage());
    case AppRoutes.landingPageRoute:
    default:
      return MaterialPageRoute(builder: (context) => const LandingPage());
  }
}
