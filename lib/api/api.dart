import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model/newsm_model/newsm_model.dart';


Future<List<NewsmModel>> fetchNews({required String newsSearch}) async {
  const api = "9296cd6682214a38a74003cf451f8138";
  final url =
      "https://newsapi.org/v2/everything?q=$newsSearch&apiKey=$api";

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final List<NewsmModel> newsList = [];
    log(response.body);

     {
      for (var article in data['articles']) {
        final news = NewsmModel.fromJson(article);
        log(article.toString());
        newsList.add(news);
      }

      log(newsList[0].description.toString());
    }

    for (var element in newsList) {
      log(element.title ?? 'null');
    }

    return newsList;
  } else {
    throw Exception('failed to load news: ${response.statusCode}');
    
  }
}
