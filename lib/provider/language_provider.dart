import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  Locale arabic = const Locale('ar');
  Locale english = const Locale('en');
  String appBarTitle = "News App";
  changeAppLanguage(BuildContext context, String language){
    if(language == "العربية"){
      context.setLocale(arabic);
      notifyListeners();
    }else{
      context.setLocale(english);
      notifyListeners();
    }
  }
  changeToArabic(BuildContext context){
    context.setLocale(arabic);
    notifyListeners();

  }
  changeToEnglish(BuildContext context){
    context.setLocale(english);
    notifyListeners();
  }
}