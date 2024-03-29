import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/articles_response.dart';
import 'package:news_app/api/sources_response.dart';

class ApiManger {
  // https://newsapi.org/v2/top-headlines/sources?apiKey=bf45f280dc68433e9a9be7cf4129b08f&category=sports

  //  https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=bf45f280dc68433e9a9be7cf4129b08f

  static const baseUrl = "newsapi.org";
  static const apiKey = "07786088d7c94536adc378f7d158cae0";
      // "bf45f280dc68433e9a9be7cf4129b08f";

  static Future<SourceResponse> getAllSources(String categoryID,String languageCode) async {
    var url = Uri.https(baseUrl, "/v2/top-headlines/sources",
        {"apiKey": apiKey, "category": categoryID,"language":languageCode});

    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    SourceResponse sourceResponse = SourceResponse.fromJson(jsonResponse);
    return sourceResponse;
  }

  static Future<ArticlesResponse> getNews(String categoryID, int index,String languageCode) async {
    var list = await getAllSources(categoryID,languageCode);
    var sourceID = list.sources?[index].id;
    var url = Uri.https(
        baseUrl, "/v2/everything", {"apiKey": apiKey, "sources": sourceID,"language":languageCode});

    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    ArticlesResponse articlesResponse = ArticlesResponse.fromJson(jsonResponse);
    return articlesResponse;
  }

  static Future<ArticlesResponse> getNewsByQuery(String categoryID, int index,String query,String languageCode) async {
    var list = await getAllSources(categoryID,languageCode);
    var sourceID = list.sources?[index].id;
    var url = Uri.https(
        baseUrl, "/v2/everything", {"apiKey": apiKey, "sources": sourceID , "q":query,"language":languageCode});

    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    ArticlesResponse articlesResponse = ArticlesResponse.fromJson(jsonResponse);
    return articlesResponse;
  }
}
