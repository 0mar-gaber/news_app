import 'package:flutter/material.dart';
import 'package:news_app/model/card_model.dart';

class CategoriesCard extends StatelessWidget {

  List<CardModel> card ;
  int index  ;

   CategoriesCard({super.key, required this.card,required this.index});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Container(
      width: 40,
      decoration: BoxDecoration(
        color: card[index].backgroundColor,
        borderRadius: index.isEven
            ?const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        )
            :const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage(card[index].imageAssets),width: width*0.3),
          Text(card[index].title,
            style: TextStyle(
              color: Colors.white,
              fontSize: width*0.05
            ),
          )
        ],
      ),
    );
  }
}
