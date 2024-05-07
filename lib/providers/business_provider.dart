import 'package:flutter/material.dart';

import '../model/article_model.dart';
import '../services/api_service.dart';

class BusinessProvider extends ChangeNotifier{
  final _apiService = APIService();
  List<Article> list = [];
  RespObj respObj = RespObj(ApiState.initial, null);
  
  Future<void> getBusinessArticle(int page) async {
    respObj = RespObj(ApiState.loading, null);
    notifyListeners();
    final response = await _apiService.getData("business",page);

    if(response.apiState == ApiState.success) {
      List<dynamic> articlesJson = response.data['articles'];

      List<Article> articles =
        articlesJson.map((item) => Article.fromJson(item)).toList();
        respObj.data = list + articles; 
        list = respObj.data;    
        respObj.apiState = ApiState.success;
        notifyListeners();
    }else{
      respObj = RespObj(ApiState.error, response.data);
      notifyListeners();
    }
  }

}