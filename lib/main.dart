import 'package:flutter/material.dart';
import 'package:news_app/home/home_screen.dart';
import 'package:news_app/home/news_Screen.dart';
import 'package:news_app/theme/app_theme.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.route:(_)=>const HomeScreen(),
        NewsScreen.route:(_)=> NewsScreen(),
      },
      initialRoute: HomeScreen.route,
      theme: AppTheme.lightTheme,
    );
  }
}

