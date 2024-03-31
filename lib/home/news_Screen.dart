
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home/articles_details_screen.dart';
import 'package:news_app/model/card_model.dart';
import 'package:news_app/provider/search_provider.dart';
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
  TextEditingController searchController = TextEditingController();
  String? searchQuery;
  late CardModel cardModel ;

  @override
  Widget build(BuildContext context) {
    CardModel cardModel = ModalRoute.of(context)!.settings.arguments as CardModel;
    String languageCode = EasyLocalization.of(context)?.currentLocale.toString() ?? "en";
    context.setLocale(EasyLocalization.of(context)?.currentLocale ?? const Locale("en"));

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    SearchProvider searchProvider = Provider.of<SearchProvider>(context);

    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/pattern.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: searchProvider.isSearchOpen
              ? AppBar(
                  toolbarHeight: height * 0.07,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Container(
                    margin: EdgeInsets.only(
                      left: width * 0.05,
                      right: width * 0.05,
                    ),
                    child: TextField(
                      onSubmitted: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      controller: searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'SearchArticle'.tr(),
                        hintStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.4)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.4),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(
                            right: width * 0.02,
                          ), // Adjust padding for suffix icon
                          child: IconButton(
                            onPressed: () {
                              searchQuery=null;
                              searchController.clear();
                              },
                            icon: Icon(Icons.clear_rounded,
                                color: Theme.of(context).colorScheme.primary,
                                size: width * 0.04),
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.02,
                          ), // Adjust padding for suffix icon
                          child: IconButton(
                            onPressed: () {
                              SearchProvider searchProvider = Provider.of<SearchProvider>(context,listen: false);
                              searchProvider.openAndCloseSearchBar();
                              searchController.clear();
                              searchQuery=null;                            },
                            icon: Icon(Icons.arrow_back_ios_sharp,
                                color: Theme.of(context).colorScheme.primary,
                                size: width * 0.04),
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                )
              : AppBar(
                  iconTheme:
                      IconThemeData(size: width * 0.05, color: Colors.white),
                  leadingWidth: width * 0.14,
                  title: Text(
                    cardModel.title,
                    style: TextStyle(fontSize: width * 0.04),
                  ),
                  toolbarHeight: height * 0.07,
                  actions: [
                    IconButton(
                        onPressed: () {
                          SearchProvider searchProvider = Provider.of<SearchProvider>(context,listen: false);
                          searchProvider.openAndCloseSearchBar();
                        },
                        icon: const Icon(Icons.search)),
                    SizedBox(
                      width: width * 0.04,
                    ),
                  ],
                ),
          body: Column(
            children: [
              BlocProvider(
                create:(context) => SourcesViewModel()..getSources(cardModel.id, languageCode),
                child: BlocBuilder<SourcesViewModel,SourcesState>(
                  builder: (context, state) {
                    if(state is SourcesError){
                      return Center(
                        child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<NewsViewModel>(context).getNews(
                                  cardModel.id,
                                  selectedSource,
                                  languageCode,
                                  searchController.toString());
                            },
                            child: const Text("try again")),
                      );

                    }
                    if( state is SourcesSuccess){
                      return DefaultTabController(
                        length: state.listOfSources.length,
                        child: TabBar(
                          onTap: (index) {
                            setState(() {
                              selectedSource =
                                  index; // Update selectedSource when a tab is tapped
                            });
                          },
                          isScrollable: true,
                          tabs: List.generate(
                            state.listOfSources.length,
                            (index) => Tab(
                              child: SourcesWidget(
                                isSelected: selectedSource == index,
                                source: state.listOfSources[index],
                              ),
                            ),
                          ),
                          dividerColor: Colors.transparent,
                          indicatorColor: Colors.transparent,
                        ),
                      );
                    }
                    return const SizedBox() ;
                  },
                ),
              ),
              Expanded(
                child: BlocProvider.value(
                  value: NewsViewModel()..getNews(cardModel.id, selectedSource, languageCode, searchQuery),
                  child: BlocBuilder<NewsViewModel, NewsState>(
                    builder: (context, state) {

                      if (state is NewsError) {
                        return Center(
                          child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<NewsViewModel>(context).getNews(
                                    cardModel.id,
                                    selectedSource,
                                    languageCode,
                                    searchController.toString());
                              },
                              child: const Text("try again")),
                        );
                      }
                      if (state is NewsSuccess) {
                        return ListView.builder(
                          itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ArticlesDetails.route,
                                    arguments: state.listOfArticles[index]);
                              },
                              child: ArticleWidget(
                                  article: state.listOfArticles[index])),
                          itemCount: state.listOfArticles.length,
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }

}
