import 'package:flutter/material.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/api/sources_response.dart';

class SourcesViewModel extends ChangeNotifier{
  List sources = [];
  String? message ;
  String? state ;
  bool isLoading = false;
   getSources(String categoryID) async {
    isLoading = true ;
    notifyListeners();
    try{
      SourceResponse response = await ApiManger.getAllSources(categoryID);
      isLoading = false ;
      if(response.status=="error"){
        message =response.message;
        state = response.status ;
        notifyListeners();

      }else{
        sources = response.sources??[];
        notifyListeners();

      }

    }catch(e){
      isLoading = false ;
      message = e.toString();
      notifyListeners();

    }
    notifyListeners();


  }
}