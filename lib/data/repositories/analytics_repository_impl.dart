import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:news_app/domain/repositories/analytics_repository.dart';

class AnalyticsRepositoryImpl extends AnalyticsRepository {
  AnalyticsRepositoryImpl(this.firebaseAnalytics);
  FirebaseAnalytics firebaseAnalytics;

  @override
  Future<void> logEvent({
    required String name,
    required Map<String, dynamic> parameters,
  }) async {
    await firebaseAnalytics.logEvent(name: name, parameters: parameters);
  }
}
