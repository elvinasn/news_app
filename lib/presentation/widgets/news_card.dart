import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/presentation/common/router/routes.dart';
import 'package:news_app/presentation/common/utils/assets.dart';
import 'package:news_app/presentation/common/utils/extensions.dart';
import 'package:news_app/presentation/widgets/container_button.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return ContainerButton(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        color: context.colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      borderRadius: BorderRadius.circular(12),
      onPressed: () {
        context.goRoute(
          ArticleRoute(id: article.id),
        );
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: article.urlToImage != null
                ? CachedNetworkImage(
                    imageUrl: article.urlToImage!,
                    width: 130,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    AppAssets.article,
                    width: 130,
                    height: 120,
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: context.styles.button3,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  5.heightBox,
                  if (article.description != null)
                    Text(
                      article.description!,
                      style: context.styles.body3,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  8.heightBox,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      article.formattedDate,
                      style: context.styles.body3
                          .copyWith(color: context.colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
