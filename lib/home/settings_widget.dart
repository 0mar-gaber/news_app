import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  String? selectedLang = "English";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return  Container(
      margin: EdgeInsets.all(width*0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          Text("language",style: TextStyle(fontWeight: FontWeight.w700,fontSize: width*0.05,color: Colors.black),),
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
      
      
              },
              value:  selectedLang,
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
