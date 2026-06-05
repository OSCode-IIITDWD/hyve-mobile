import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hyve/features/onboarding/view/onboarding_page.dart';
import 'package:hyve/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://iqcttbjdyapojoflzhoy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlxY3R0YmpkeWFwb2pvZmx6aG95Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzkzNDQ4OTAsImV4cCI6MjA5NDkyMDg5MH0.mRI8LdiPY537IMBUjEXiYryBxaDFUi7O83skwlXF47U',
  );

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
