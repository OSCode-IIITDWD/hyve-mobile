import 'package:flutter/material.dart';
import 'package:hyve/features/cabin_location/view/cabin_home_page.dart';
import 'package:hyve/features/lost_and_found/view/lost_and_found_page.dart';
import 'package:hyve/features/onboarding/view/onboarding_page.dart';
import 'package:hyve/core/theme/app_theme.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hyve',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const OnBoardingScreen(),
    );
  }
}
