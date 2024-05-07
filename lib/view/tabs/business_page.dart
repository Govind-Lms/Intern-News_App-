import 'package:flutter/material.dart';
import 'package:news_api_app/providers/business_provider.dart';
import 'package:news_api_app/view/pages/detail_page.dart';
import 'package:news_api_app/view/widgets/news_card.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/article_model.dart';
import '../../services/api_service.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({super.key});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  int page = 1;
  @override
  void initState() {
    super.initState();
    context.read<BusinessProvider>().getBusinessArticle(page);
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  
  _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      page = page + 1;
    });
    print("page = $page");
    Provider.of<BusinessProvider>(context, listen: false)
        .getBusinessArticle(page);
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BusinessProvider>(
      builder: (context, article, child) {
        final response = article.respObj;
        if (response.apiState == ApiState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (response.apiState == ApiState.success) {
          List<Article> articles = response.data as List<Article>;
          return SmartRefresher(
            header: const ClassicHeader(),
            onRefresh: _onRefresh,
            controller: refreshController,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: articles.length,
                itemBuilder: (context, index) {
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
                }),
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
