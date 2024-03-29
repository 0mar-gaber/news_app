import 'package:flutter/material.dart';

class CardModel{
  String imageAssets ;
  String title ;
  String id ;
  Color? backgroundColor ;

  CardModel({required this.backgroundColor,required this.imageAssets,required this.title,required this.id});
}