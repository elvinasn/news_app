import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/presentation/common/router/routes.dart';
import 'package:news_app/presentation/common/store/news_store.dart';
import 'package:news_app/presentation/common/utils/assets.dart';
import 'package:news_app/presentation/common/utils/extensions.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key, required this.articleId});
  final String articleId;

  @override
  Widget build(BuildContext context) {
    final newsStore = GetIt.I<NewsStore>();

    const expandedHeight = 200.0;
    const collapsedHeight = kToolbarHeight;

    final article = newsStore.getArticle(articleId);

    if (article == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Article not found.'),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: expandedHeight,
            titleSpacing: 0,
            collapsedHeight: collapsedHeight,
            centerTitle: false,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final paddingTop = MediaQuery.of(context).padding.top;

                final delta =
                    constraints.maxHeight - paddingTop - collapsedHeight;
                final opacity = 1 - delta / (expandedHeight - collapsedHeight);
                return FlexibleSpaceBar(
                  centerTitle: false,
                  title: Opacity(
                    opacity: opacity,
                    child: const Text(
                      'OnBoardAppMVP',
                    ),
                  ),
                  collapseMode: CollapseMode.pin,
                  titlePadding: const EdgeInsets.only(left: 60, bottom: 16),
                  background: article.urlToImage != null
                      ? CachedNetworkImage(
                          imageUrl: article.urlToImage!,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          AppAssets.article,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                );
              },
            ),
            pinned: true,
            floating: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverFillRemaining(
              child: Column(
                children: [
                  Text(
                    article.title,
                    style: context.styles.h4,
                  ),
                  16.heightBox,
                  if (article.description != null)
                    Text(
                      article.description!,
                      style: context.styles.body2,
                    ),
                  24.heightBox,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (article.author != null)
                          Text(
                            article.author!,
                            style: context.styles.body3
                                .copyWith(color: context.colors.grey),
                          ),
                        Text(
                          article.formattedDate,
                          style: context.styles.body3
                              .copyWith(color: context.colors.grey),
                        ),
                      ],
                    ),
                  ),
                  12.heightBox,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pushRoute(WebViewRoute(url: article.url));
                      },
                      child: Text(
                        'Read Full Article',
                        style: context.styles.button1,
                      ),
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
