import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier{
  bool isSearchOpen = false ;
  // String? searchQuery ;
  // search(String searchQuery){
  //
  // }
  openAndCloseSearchBar(){
    isSearchOpen = !isSearchOpen;
    notifyListeners();
  }
}