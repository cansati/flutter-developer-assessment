import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsService with ChangeNotifier {
  late FirebaseAnalytics _analytics;

  AnalyticsService() {
    _analytics = FirebaseAnalytics.instance;
  }

  setAnalytics(FirebaseAnalytics analytics) {
    _analytics = analytics;
  }

  FirebaseAnalytics getAnalytics() {
    return _analytics;
  }
}
