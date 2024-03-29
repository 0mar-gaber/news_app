import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/provider/language_provider.dart';
import 'package:provider/provider.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  String? selectedLang ;

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider  = Provider.of<LanguageProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    if(EasyLocalization.of(context)?.currentLocale==const Locale("ar")){
      selectedLang = "العربية";
    }else{
      selectedLang = "English";
    }
    return  Container(
      margin: EdgeInsets.all(width*0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          Text("Language".tr(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: width*0.05,color: Colors.black),),
          Container(
            margin: EdgeInsets.all(width*0.04),
            decoration:BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Theme.of(context).colorScheme.primary)
            ) ,
            width:width ,
            child: DropdownButton(
              items: ["العربية", "English"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) {
               setState(() {
                 selectedLang = value;
               });
               languageProvider.changeAppLanguage(context, selectedLang!);



              },
              value: selectedLang,
              alignment: AlignmentDirectional.topStart,
              isExpanded: true,
              padding: const EdgeInsets.all(12),
              dropdownColor: Colors.white,
              underline: const SizedBox(),
              iconDisabledColor: Theme.of(context).colorScheme.primary,
              iconEnabledColor: Theme.of(context).colorScheme.primary,
              icon: Icon(Icons.keyboard_arrow_down_sharp, size: width * 0.04),
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: width * 0.04, color: Theme.of(context).colorScheme.primary),
            ),
      
      
          ),
      
      
      
      
        ],
      ),
    );
  }
}
