import 'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart';
import 'package:news_app/reusable_component/article_widget_2.dart';

class ArticlesDetails extends StatelessWidget {
  static const String route = "Articles Details";

  const ArticlesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Article article = ModalRoute.of(context)!.settings.arguments as Article;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/pattern.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(size: width * 0.05, color: Colors.white),
            leadingWidth: width * 0.14,
            title: Text(
              "Articles Details",
              style: TextStyle(fontSize: width * 0.04),
            ),
            toolbarHeight: height * 0.07,
          ),
          body: Container(
            margin: EdgeInsets.only(top: height*0.03),
            child: Column(
              children: [
                ArticleWidget2(article: article),
              ],
            ),
          ),
        ));
  }
}
