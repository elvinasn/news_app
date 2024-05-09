// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewsStore on _NewsStoreBase, Store {
  Computed<List<Article>>? _$filteredArticlesComputed;

  @override
  List<Article> get filteredArticles => (_$filteredArticlesComputed ??=
          Computed<List<Article>>(() => super.filteredArticles,
              name: '_NewsStoreBase.filteredArticles'))
      .value;

  late final _$articlesAtom =
      Atom(name: '_NewsStoreBase.articles', context: context);

  @override
  ObservableList<Article> get articles {
    _$articlesAtom.reportRead();
    return super.articles;
  }

  @override
  set articles(ObservableList<Article> value) {
    _$articlesAtom.reportWrite(value, super.articles, () {
      super.articles = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_NewsStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_NewsStoreBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$refreshAsyncAction =
      AsyncAction('_NewsStoreBase.refresh', context: context);

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  late final _$_NewsStoreBaseActionController =
      ActionController(name: '_NewsStoreBase', context: context);

  @override
  Article? getArticle(String id) {
    final _$actionInfo = _$_NewsStoreBaseActionController.startAction(
        name: '_NewsStoreBase.getArticle');
    try {
      return super.getArticle(id);
    } finally {
      _$_NewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
articles: ${articles},
isLoading: ${isLoading},
filteredArticles: ${filteredArticles}
    ''';
  }
}
