import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final VoidCallback onTap;
  const NewsCard(
      {super.key,
      required this.onTap,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              // boxShadow: [
              //   BoxShadow(
              //     offset: Offset(3, 3),
              //     color: Colors.black12,
              //     blurRadius: 6.0,
              //   )
              // ]),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Hero(
                        tag: title,
                        child: CachedNetworkImage(
                          imageUrl: urlToImage,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Placeholder(),
                          errorWidget: (context, url, error) =>
                              const Placeholder(),
                        ),),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          title,
                           maxLines: 1,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        width: 200.0,
                        child: Text(
                          author,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 1.0,
          color: Colors.grey,
        )
      ],
    );
  }
}
