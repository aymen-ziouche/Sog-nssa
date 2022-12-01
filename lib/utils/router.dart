import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sognssa/controllers/database_controller.dart';
import 'package:sognssa/utils/args_models/add_shipping_address_args.dart';
import 'package:sognssa/utils/routes.dart';
import 'package:sognssa/views/pages/bottom_navbar.dart';
import 'package:sognssa/views/pages/checkout/add_shipping_address_page.dart';
import 'package:sognssa/views/pages/checkout/checkout_page.dart';
import 'package:sognssa/views/pages/checkout/shipping_addresses_page.dart';
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
    case AppRoutes.checkoutPageRoute:
      final database = settings.arguments as Database;
      return MaterialPageRoute(
        builder: (_) => Provider<Database>.value(
            value: database, child: const CheckoutPage()),
        settings: settings,
      );
    case AppRoutes.productDetailsRoute:
      final args = settings.arguments as Map<String, dynamic>;
      final product = args['product'];
      final database = args['database'];
      return MaterialPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: ProductDetails(product: product),
        ),
        settings: settings,
      );

    case AppRoutes.shippingAddressesRoute:
      final database = settings.arguments as Database;
      return MaterialPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: const ShippingAddressesPage(),
        ),
        settings: settings,
      );
    case AppRoutes.addShippingAddressRoute:
      final args = settings.arguments as AddShippingAddressArgs;
      final database = args.database;
      final shippingAddress = args.shippingAddress;

      return MaterialPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: AddShippingAddressPage(
            shippingAddress: shippingAddress,
          ),
        ),
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