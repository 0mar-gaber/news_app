import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/model/article_model.dart';

class NewsViewModel extends Cubit<NewsState>{
  NewsViewModel():super(NewsLoading());
  getNews(String categoryID ,int index , String languageCode,String? searchQuery) async {
    try{
      if(searchQuery ==null||searchQuery==""){
        var newsResponse = await ApiManger.getNews(categoryID, index, languageCode);
        if(newsResponse.status=="error"){
          emit(NewsError(errorMessage: newsResponse.message??""));
        }else{
          var newsList = newsResponse.articles??[];
          emit(NewsSuccess(listOfArticles: newsList));
        }
      }else{
        var newsResponse = await ApiManger.getNewsByQuery(categoryID, index, searchQuery, languageCode);
        if(newsResponse.status=="error"){
          emit(NewsError(errorMessage: newsResponse.message??"",statues: newsResponse.status.toString()));
        }else{
          var newsList = newsResponse.articles??[];
          emit(NewsSuccess(listOfArticles: newsList));
        }
      }

    }catch(e){
      emit(NewsError(errorMessage: e.toString()));
    }
  }
}

abstract class NewsState{}
class NewsLoading extends NewsState {}
class NewsError extends NewsState {
  String errorMessage ;
  String statues ;
  NewsError({required this.errorMessage,this.statues=""});
}
class NewsSuccess extends NewsState {
  List<Article> listOfArticles ;
  NewsSuccess({required this.listOfArticles});
}