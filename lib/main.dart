import 'package:flutter/material.dart';
import 'package:sognssa/utils/router.dart';
import 'package:sognssa/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sognssa',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF131416),
        primaryColor: const Color(0xFFBF3FCA),
      ),
      onGenerateRoute: onGenerate,
      initialRoute: AppRoutes.authPageRoute,
    );
  }
}
