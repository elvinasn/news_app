import 'package:news_app/domain/repositories/analytics_repository.dart';

class LogEvent {
  LogEvent(this._analyticsRepository);
  final AnalyticsRepository _analyticsRepository;

  Future<void> execute({
    required String name,
    required Map<String, dynamic> parameters,
  }) {
    return _analyticsRepository.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}
