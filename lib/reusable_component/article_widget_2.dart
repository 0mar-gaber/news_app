import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/model/article_model.dart';
import 'package:url_launcher/url_launcher.dart';


class ArticleWidget2 extends StatelessWidget {
  Article article;

  ArticleWidget2({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    DateTime dateTime = DateTime.parse(article.publishedAt ?? "");
    String dateString =
        '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            imageUrl: article.urlToImage ??
                "https://st3.depositphotos.com/23594922/31822/v/450/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
            fit: BoxFit.cover,
            width: width,
            height: height * 0.3,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Container(
          margin: EdgeInsets.all(width * 0.02),
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${article.source!.name!}.",
                style: TextStyle(
                  fontSize: width * 0.02,
                  color: const Color.fromRGBO(121, 130, 139, 1.0),
                ),
              ),
              Text(
                article.title!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: width * 0.02,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),

              Container(
                margin: EdgeInsets.only(right: height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      "assets/images/UI-System-Icons-Update.svg",
                      width: width * 0.02,
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Text(
                      dateString,
                      style: TextStyle(
                        fontSize: width * 0.02,
                        color: const Color.fromRGBO(121, 130, 139, 1.0),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: height*0.01,),
        Container(
          margin: EdgeInsets.all(width*0.025), 
          padding: EdgeInsets.only(
            top: height*0.02,
            left: width*0.02,
            right: width*0.02
          ),
          width: width,
          height: height*0.43,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,

          ),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: ListView(
                  children: [
                    Text(article.description??"no description found :(",style: TextStyle(
                      color: Colors.black,
                      fontSize: width*0.025,
                      fontWeight: FontWeight.w300,
                      wordSpacing: 1,

                    ),),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                  child:InkWell(
                    onTap: () {
                      navigateToUrl(article.url!);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: height * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Text(
                            "ViewFullArticles".tr(),
                            style: TextStyle(
                              fontSize: width * 0.03,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Icon(Icons.play_arrow_sharp,size: width*0.05,),

                        ],
                      ),
                    ),
                  )

              )
            ],
          ),
        )
      ],
    );
  }
  void navigateToUrl(String url) async {
    if (await canLaunchUrl (Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('Could not launch URL');
    }
  }
}
