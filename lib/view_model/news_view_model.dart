import 'package:flutter/material.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/api/articles_response.dart';

class NewsViewModel extends ChangeNotifier{
  List articles = [];
  String? message;
  String? state ;
  bool isLoading= false;
  gatNews(categoryID, index) async {
    isLoading = true ;
    try{
      ArticlesResponse response = await ApiManger.getNews(categoryID, index) ;
      isLoading = false ;
      notifyListeners();
      if(response.status=="error"){
        message= response.message;
        state = response.status;
      }else{
        articles = response.articles??[];
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