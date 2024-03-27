import 'package:flutter/material.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/model/card_model.dart';

import '../model/sources_model.dart';
import '../reusable_component/article_widget.dart';
import '../reusable_component/source_widget.dart';

class NewsScreen extends StatefulWidget {
  static const String route = "news screen";
  const NewsScreen({super.key,});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int selectedSource = 0;
  @override
  Widget build(BuildContext context) {
    CardModel cardModel = ModalRoute.of(context)!.settings.arguments as CardModel;
    var height = MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;




    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/pattern.jpg"),fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(size: width*0.05,color: Colors.white),
          leadingWidth: width*0.14,
          title: Text(
            cardModel.title,
            style: TextStyle(fontSize: width*0.04),),
          toolbarHeight: height*0.07,
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
            SizedBox(width: width*0.04,),

          ],

        ),
        body: Column(
          children: [
            FutureBuilder(
                future: ApiManger.getAllSources(cardModel.title),
                builder: (context, snapshot) {
                  var sources = snapshot.data?.sources??[];
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return DefaultTabController(
                        length: sources.length,
                        child: TabBar(
                          onTap: (index) {
                            setState(() {
                              selectedSource = index ;

                            });
                          },
                          isScrollable: true,
                          tabs:sources.map((source) => SourcesWidget(
                            isSelected: selectedSource == sources.indexOf(source),
                            source: SourceModel(name: ""),
                          )).toList(),
                          dividerColor: Colors.transparent,
                          indicatorColor: Colors.transparent,
                        )
                    );
                  }
                  if(snapshot.hasError||snapshot.data?.status=="error"){
                    return Center(
                      child: ElevatedButton(onPressed: (){
                        setState(() {});
                      }, child: const Text("try again")),
                    );
                  }
                  return DefaultTabController(
                      length: sources.length,
                      child: TabBar(
                        onTap: (index) {
                          setState(() {
                            selectedSource = index ;
                          });
                        },
                        isScrollable: true,
                        tabs:sources.map((source) => SourcesWidget(
                          isSelected: selectedSource == sources.indexOf(source),
                          source: source,
                        )).toList(),
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                      )
                  );

                },
            ),
            Expanded(
              child: FutureBuilder(
                  future: ApiManger.getNews(cardModel.title,selectedSource),
                  builder: (context, snapshot) {
                    var articles = snapshot.data?.articles??[];
              
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.hasError||snapshot.data?.status=="error"){
                      return Center(
                        child: ElevatedButton(onPressed: (){
                          setState(() {});
                        }, child: const Text("try again")),
                      );
                    }
                    return ListView.builder(
                        itemBuilder: (context, index) => ArticleWidget(article: articles[index]),
                      itemCount: articles.length,
                    );
                  },
              ),
            )
          ],
        ),

      )
    );
  }
}
