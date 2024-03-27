import 'package:flutter/material.dart';
import 'package:news_app/model/sources_model.dart';

class SourcesWidget extends StatelessWidget {
  SourceModel source ;
  bool isSelected ;
   SourcesWidget({super.key,required this.isSelected,required this.source});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: width*0.015),
      height: height*0.04,
      width: width*0.18,
      decoration: BoxDecoration(
        color: isSelected
            ?Theme.of(context).colorScheme.primary
            :Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: width*0.003
        ),

      ),
      child: Center(
        child: Text(
          source.name!,
            textAlign: TextAlign.center,
          style: TextStyle(
            color: !isSelected
                ?Theme.of(context).colorScheme.primary
                :Colors.white,
            fontSize: width*0.018,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
