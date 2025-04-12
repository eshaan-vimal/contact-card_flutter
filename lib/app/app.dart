import 'package:flutter/material.dart';

import 'package:contact_card/app/app_theme.dart';
import 'package:contact_card/features/home/pages/home_page.dart';


class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      title: 'QR Contact Card',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}