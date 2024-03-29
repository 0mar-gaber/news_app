import 'package:flutter/material.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/api/articles_response.dart';

class NewsViewModel extends ChangeNotifier{
  List articles = [];
  String? message;
  String? state ;
  bool isLoading= false;
  String? searchQuery;

  getSearchQuery(String query){
    searchQuery = query ;
    notifyListeners();
  }

  gatNews(categoryID, index) async {
    isLoading = true ;
    try{
      if(searchQuery==null){
        ArticlesResponse response = await ApiManger.getNews(categoryID, index) ;
        isLoading = false ;
        notifyListeners();
        if(response.status=="error"){
          message= response.message;
          state = response.status;
        }else{
          articles = response.articles??[];
        }
      }
      else{
        ArticlesResponse response = await ApiManger.getNewsByQuery(categoryID, index,searchQuery!) ;
        isLoading = false ;
        notifyListeners();
        if(response.status=="error"){
          message= response.message;
          state = response.status;
        }else{
          articles = response.articles??[];
        }
      }

      notifyListeners();
    }catch(e){
      message =e.toString();
      isLoading = false ;
      notifyListeners();

    }
    notifyListeners();

  }

}