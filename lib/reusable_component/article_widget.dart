import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/model/article_model.dart';

class ArticleWidget extends StatelessWidget {
  Article article ;
   ArticleWidget({super.key,required this.article});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    DateTime dateTime = DateTime.parse(article.publishedAt??"");
    String dateString = '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';



    return Container(
      margin: EdgeInsets.all(width*0.06),
      height: height*0.4,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage??"https://st3.depositphotos.com/23594922/31822/v/450/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
              fit:BoxFit.cover,
              width: width,
              height: height*0.3,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(height: height*0.01,),
          Text(
            "${article.source!.name!}.",
            style: TextStyle(
              fontSize: width*0.02,
              color: const Color.fromRGBO(121, 130, 139, 1.0),

            ),
          ),
          Text(
              article.title!,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: width*0.02,
              color: Colors.black,


            ),
          ),

          Container(
            margin: EdgeInsets.only(right: height*0.02),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset("assets/images/UI-System-Icons-Update.svg",width: width*0.02,),
                SizedBox(width: width*0.01,),
                Text(
                  dateString,
                  style: TextStyle(
                    fontSize: width*0.02,
                    color: const Color.fromRGBO(121, 130, 139, 1.0),

                  ),
                ),
              ],
            ),

          )

        ],
      ),

    );
  }
}
