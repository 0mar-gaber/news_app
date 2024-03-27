import 'package:flutter/material.dart';
import 'package:news_app/home/news_Screen.dart';

import '../model/card_model.dart';
import '../reusable_component/categories_card.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({super.key});

  List<CardModel> card = [
    CardModel(backgroundColor: const Color.fromRGBO(201, 28, 34, 1.0),
        imageAssets: "assets/images/sports.png",
        title: "Sports"),
    CardModel(backgroundColor: const Color.fromRGBO(2, 32, 108, 1.0),
        imageAssets: "assets/images/clapboard.png",
        title: "entertainment"),
    CardModel(backgroundColor: const Color.fromRGBO(153, 153, 162, 1.0),
        imageAssets: "assets/images/healths.png",
        title: "health"),
    CardModel(backgroundColor: const Color.fromRGBO(88, 92, 110, 1.0),
        imageAssets: "assets/images/busniess.png",
        title: "business"),
    CardModel(backgroundColor: const Color.fromRGBO(72, 130, 207, 1.0),
        imageAssets: "assets/images/technology.png",
        title: "technology"),
    CardModel(
        backgroundColor: const Color.fromRGBO(42, 72, 86, 0.8980392156862745),
        imageAssets: "assets/images/sciences.png",
        title: "science"),
  ];


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      margin: EdgeInsets.only(
          left: width * 0.06, right: width * 0.06, top: width * 0.035),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pick your category",
            style: TextStyle(
                color: const Color.fromRGBO(79, 90, 105, 1.0),
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600
            ),
          ),
          Text(
            "of interest",
            style: TextStyle(
                color: const Color.fromRGBO(79, 90, 105, 1.0),
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: height * 0.02,),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: width * 0.03, right: width * 0.03,),
              child: GridView.builder(
                itemBuilder: (context, index) =>
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, NewsScreen.route, arguments: card[index]);
                      },
                      child: CategoriesCard(
                        card: card,
                        index: index,
                      ),
                    ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: width * 0.04,
                  mainAxisSpacing: height * 0.02,
                ),
                itemCount: 6,
              ),
            ),
          )
        ],
      ),
    );
  }
}
