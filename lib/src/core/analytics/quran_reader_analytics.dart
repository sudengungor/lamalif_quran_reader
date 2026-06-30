/// Optional analytics hook for host apps.
abstract interface class QuranReaderAnalytics {
  void logEvent(String name, [Map<String, Object>? parameters]);
}

/// Default no-op analytics implementation.
final class NoOpQuranReaderAnalytics implements QuranReaderAnalytics {
  const NoOpQuranReaderAnalytics();

  @override
  void logEvent(String name, [Map<String, Object>? parameters]) {}
}
