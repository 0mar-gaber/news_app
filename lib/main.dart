import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home/articles_details_screen.dart';
import 'package:news_app/home/home_screen.dart';
import 'package:news_app/home/news_Screen.dart';
import 'package:news_app/provider/language_provider.dart';
import 'package:news_app/provider/search_provider.dart';
import 'package:news_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'bloc_observer.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => LanguageProvider(),
    child: EasyLocalization(
        saveLocale: true,
        startLocale:const Locale("en") ,
        supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
        path: 'assets/translations',
        fallbackLocale: const Locale("en"),
        child: const MyApp()),
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: {
        HomeScreen.route:(_)=>const HomeScreen(),
        NewsScreen.route:(_)=> ChangeNotifierProvider(
            create:(context) => SearchProvider(),
            child:  const NewsScreen()),
        ArticlesDetails.route:(_)=>const ArticlesDetails(),
      },
      initialRoute: HomeScreen.route,
      theme: AppTheme.lightTheme,
    );
  }
}

