import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_api_app/model/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final Article article;
  const DetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(article.author ?? ''),
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: article.title ?? '',
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ?? '',
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  article.title ?? '',
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 20.0,
                    ),
                    Text(
                      article.author ?? '',
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Icon(
                      Icons.date_range,
                      size: 20.0,
                    ),
                    Text(
                      article.publishedAt ?? '',
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  '${article.description} \n ${article.content}',
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: InkWell(
              onTap: () async {
                if (await canLaunch(article.url ?? 'www.google.com')) {
                  await launch(article.url ?? 'wwww.google.com');
                } else {
                  throw 'Could not launch ${article.url}';
                }
              },
              child: Container(
                width: 100.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(child: Text('Visit Web')),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
