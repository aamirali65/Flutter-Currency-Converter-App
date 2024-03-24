import 'dart:convert';

import 'package:currensee/models/articleModal.dart';
import 'package:http/http.dart' as http;
class News{
  List<ArticlesModal> news = [];
  Future<void> getNews() async {
    var url = 'https://newsapi.org/v2/everything?q=finance&sources=bbc-news&apiKey=9c5ff62977ca4f2d83dcf0f8b2473bb9';
    var response = await http.get(Uri.parse(url)); // Use http.get here
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        jsonData["articles"].forEach((element){
          if(element['urlToImage']!=null && element['description']!=null){
            ArticlesModal articlesModal = ArticlesModal(
                author : element['author'],
                title : element['title'],
                description : element['description'],
                url : element['url'],
                urlToImage : element['urlToImage'],
                content : element['content'],
                publishedAt: element['publishedAt']
            );
            news.add(articlesModal);
          }
        });
      } else {
        print("Error from API: ${jsonData['message']}");
      }
    } else {
      print("Failed to fetch news. Status code: ${response.statusCode}");
    }
  }
}