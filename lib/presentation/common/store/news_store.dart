import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/domain/use-cases/get_top_headlines.dart';
import 'package:news_app/presentation/common/utils/message_toaster.dart';

part 'news_store.g.dart';

// ignore: library_private_types_in_public_api
class NewsStore = _NewsStoreBase with _$NewsStore;

abstract class _NewsStoreBase with Store {
  _NewsStoreBase(
    this._getTopHeadlines,
  );
  final GetTopHeadlines _getTopHeadlines;

  @observable
  ObservableList<Article> articles = ObservableList.of([]);

  @observable
  bool isLoading = false;

  @computed
  List<Article> get filteredArticles =>
      articles.where((element) => element.title != '[Removed]').toList();

  @action
  Future<void> init() async {
    isLoading = true;
    final result = await _getTopHeadlines.execute();
    result.fold(
      (failure) => MessageToaster.showMessage(failure.message, ToastType.error),
      (articles) => this.articles = ObservableList.of(articles),
    );
    isLoading = false;
  }

  @action
  Article? getArticle(String id) {
    return articles.firstWhereOrNull((element) => element.id == id);
  }

  @action
  Future<void> refresh() async {
    await init();
  }
}
