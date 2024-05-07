import 'package:flutter/material.dart';
import 'package:news_api_app/model/article_model.dart';
import 'package:news_api_app/providers/tech_provider.dart';
import 'package:news_api_app/services/api_service.dart';
import 'package:news_api_app/view/pages/detail_page.dart';
import 'package:news_api_app/view/widgets/news_card.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TechPage extends StatefulWidget {
  const TechPage({super.key});

  @override
  State<TechPage> createState() => _TechPageState();
}

class _TechPageState extends State<TechPage> {
  @override
  void initState() {
    super.initState();
    (context).read<TechProvider>().getTechArticles();
  }
  RefreshController refreshController = RefreshController(initialRefresh: false);
  void _onRefresh() async{
    await Future.delayed(const Duration(seconds: 1));
  
    Provider.of<TechProvider>(context, listen: false)
        .getTechArticles();
    refreshController.refreshCompleted();
  }

  

  @override
  Widget build(BuildContext context) {
    return Consumer<TechProvider>(
      builder: (context, article, child) {
        final response = article.respObj;
        if (response.apiState == ApiState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (response.apiState == ApiState.success) {
          List<Article> articles = response.data as List<Article>;
          return SmartRefresher(
            controller: refreshController,
            header: const ClassicHeader(),
            onRefresh: _onRefresh,
            enablePullUp: true,
            onLoading: (){
              (context).read<TechProvider>().getMoreTechArticles();
              refreshController.loadComplete();
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                final article = articles[index];
                return NewsCard(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          article: article,
                        ),
                      ),
                    );
                  },
                  author: article.author ?? '',
                  content: article.content ?? '',
                  description: article.description ?? '',
                  publishedAt: article.publishedAt ?? '',
                  title: article.title ?? '',
                  url: article.url ?? '',
                  urlToImage: article.urlToImage ?? '',
                );
              },
            ),
          );
        } else if (response.apiState == ApiState.error) {
          return Center(
            child: Text(response.data.toString()),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
