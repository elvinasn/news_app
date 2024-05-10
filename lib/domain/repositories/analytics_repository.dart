// ignore: one_member_abstracts
abstract class AnalyticsRepository {
  Future<void> logEvent({
    required String name,
    required Map<String, dynamic> parameters,
  });
}
