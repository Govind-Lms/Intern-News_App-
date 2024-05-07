import 'package:dio/dio.dart';

const baseUrl = "https://newsapi.org/v2";
const apiKey = "0f755d44c1514d15bfe9721c0aeb3444";
const perPage = 5;

enum ApiState { initial, loading, success, error }

class RespObj {
  ApiState apiState;
  dynamic data;

  RespObj(this.apiState, this.data);
}

class APIService {
  final Dio dio = Dio();
  List<dynamic> lists =[];
  Future<RespObj> getData(String category, int pageKey) async {
    RespObj respObj;
    try {
      final response = await dio.get(
        "$baseUrl/top-headlines",
        queryParameters: {
          "country": "us",
          "category": category,
          "pageSize" : perPage,
          "page" : pageKey,
          "apiKey": apiKey,
        },
      );
      print(response.realUri);

      if (response.statusCode == 200) {
        respObj = RespObj(ApiState.success, response.data);
      } else {
        respObj = RespObj(ApiState.error, "Something went wrong");
      }
      return respObj;
    } on DioException catch (e) {
      RespObj respObj;
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        if (statusCode == 404) {
          respObj = RespObj(ApiState.error, "Not found");
        } else if (statusCode == 500) {
          respObj = RespObj(ApiState.error, "Server error");
        } else {
          respObj = RespObj(ApiState.error, "Unknown error");
        }

        return respObj;
      }
      throw Exception(e.error.toString());
    }
  }
}
