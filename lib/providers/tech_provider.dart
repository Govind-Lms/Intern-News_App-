import 'package:flutter/material.dart';
import 'package:news_api_app/model/article_model.dart';
import 'package:news_api_app/services/api_service.dart';

class TechProvider extends ChangeNotifier{
  final _apiService = APIService();
  List<Article> list = [];
  RespObj respObj = RespObj(ApiState.initial, null);


  Future<void> getTechArticles(int page) async{
    respObj = RespObj(ApiState.loading, null);
    notifyListeners();
    final response = await _apiService.getData("technology",page);

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