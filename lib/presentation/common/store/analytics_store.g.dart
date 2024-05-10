// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnalyticsStore on _AnalyticsStore, Store {
  late final _$isEventLoggedAtom =
      Atom(name: '_AnalyticsStore.isEventLogged', context: context);

  @override
  bool get isEventLogged {
    _$isEventLoggedAtom.reportRead();
    return super.isEventLogged;
  }

  @override
  set isEventLogged(bool value) {
    _$isEventLoggedAtom.reportWrite(value, super.isEventLogged, () {
      super.isEventLogged = value;
    });
  }

  late final _$logEventAsyncAction =
      AsyncAction('_AnalyticsStore.logEvent', context: context);

  @override
  Future<void> logEvent(String eventName, Map<String, dynamic>? parameters) {
    return _$logEventAsyncAction
        .run(() => super.logEvent(eventName, parameters));
  }

  @override
  String toString() {
    return '''
isEventLogged: ${isEventLogged}
    ''';
  }
}
