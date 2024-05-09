import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/presentation/common/store/news_store.dart';
import 'package:news_app/presentation/widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final newsStore = GetIt.I<NewsStore>();

  @override
  void initState() {
    newsStore.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Headlines'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await newsStore.refresh();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Observer(
            builder: (_) {
              if (newsStore.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final articles = newsStore.filteredArticles;

              if (articles.isEmpty) {
                return const Center(child: Text('No articles available.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 32),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return ArticleCard(article: article);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
