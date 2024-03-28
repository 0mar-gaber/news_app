import 'package:flutter/material.dart';
import 'package:news_app/home/articles_details_screen.dart';
import 'package:news_app/model/card_model.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:news_app/view_model/sources_view_model.dart';
import 'package:provider/provider.dart';
import '../reusable_component/article_widget.dart';
import '../reusable_component/source_widget.dart';

class NewsScreen extends StatefulWidget {
  static const String route = "news screen";

  const NewsScreen({
    super.key,
  });

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int selectedSource = 0;
  var sourcesViewModel = SourcesViewModel();
  var newsViewModel = NewsViewModel();

  @override
  @override
  Widget build(BuildContext context) {
    CardModel cardModel = ModalRoute.of(context)!.settings.arguments as CardModel;
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
              cardModel.title,
              style: TextStyle(fontSize: width * 0.04),
            ),
            toolbarHeight: height * 0.07,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              SizedBox(
                width: width * 0.04,
              ),
            ],
          ),
          body: Column(
            children: [
              ChangeNotifierProvider.value(
                value: sourcesViewModel..getSources(cardModel.title),
                child: Consumer<SourcesViewModel>(
                  builder: (context, value, child) {
                    if (sourcesViewModel.isLoading) {
                      return DefaultTabController(
                        length: sourcesViewModel.sources.length,
                        child: TabBar(
                          onTap: (index) {
                            setState(() {
                              selectedSource =
                                  index; // Update selectedSource when a tab is tapped
                            });
                          },
                          isScrollable: true,
                          tabs: List.generate(
                            sourcesViewModel.sources.length,
                            (index) => Tab(
                              child: SourcesWidget(
                                isSelected: selectedSource == index,
                                source: sourcesViewModel.sources[index],
                              ),
                            ),
                          ),
                          dividerColor: Colors.transparent,
                          indicatorColor: Colors.transparent,
                        ),
                      );
                    } else if (sourcesViewModel.message != null) {

                      return Center(
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {});
                            },
                            child: const Text("try again")),
                      );
                    } else {
                      return DefaultTabController(
                        length: sourcesViewModel.sources.length,
                        child: TabBar(
                          onTap: (index) {
                            setState(() {
                              selectedSource =
                                  index; // Update selectedSource when a tab is tapped
                            });
                          },
                          isScrollable: true,
                          tabs: List.generate(
                            sourcesViewModel.sources.length,
                            (index) => Tab(
                              child: SourcesWidget(
                                isSelected: selectedSource == index,
                                source: sourcesViewModel.sources[index],
                              ),
                            ),
                          ),
                          dividerColor: Colors.transparent,
                          indicatorColor: Colors.transparent,
                        ),
                      );
                    }
                  },
                ),
              ),
              ChangeNotifierProvider.value(
                value: newsViewModel..gatNews(cardModel.title, selectedSource),
                child: Expanded(
                  child: Consumer<NewsViewModel>(
                    builder: (context, value, child) {
                      if (newsViewModel.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      else if (newsViewModel.message != null) {

                        return Center(
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: const Text("try again")),
                        );
                      }
                      else {

                        return ListView.builder(
                          itemBuilder: (context, index) =>
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, ArticlesDetails.route,arguments: newsViewModel.articles[index]);
                                },
                                  child: ArticleWidget(article: newsViewModel.articles[index])),
                          itemCount: newsViewModel.articles.length,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
