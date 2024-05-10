// lib/presentation/home/home_store.dart
import 'package:mobx/mobx.dart';
import 'package:news_app/domain/use-cases/log_event.dart';

part 'analytics_store.g.dart';

// ignore: library_private_types_in_public_api
class AnalyticsStore = _AnalyticsStore with _$AnalyticsStore;

abstract class _AnalyticsStore with Store {
  _AnalyticsStore(this._logEvent);
  final LogEvent _logEvent;

  @action
  Future<void> logEvent(
    String eventName,
    Map<String, dynamic>? parameters,
  ) async {
    await _logEvent.execute(
      name: eventName,
      parameters: parameters ?? {},
    );
  }
}
