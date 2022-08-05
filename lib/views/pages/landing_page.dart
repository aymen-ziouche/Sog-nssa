import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sognssa/controllers/auth_controllers.dart';
import 'package:sognssa/services/auth.dart';
import 'package:sognssa/views/pages/auth_page.dart';
import 'package:sognssa/views/pages/bottom_navbar.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return ChangeNotifierProvider<AuthController>(
              create: (_) => AuthController(auth: auth),
              child: const AuthPage(),
            );
          }
          return ChangeNotifierProvider<AuthController>(
            create: (_) => AuthController(auth: auth),
            child:  const BottonNavBar(),
          );
        }
        // TODO: We will refactor this to make one component for loading
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}