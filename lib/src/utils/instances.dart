import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseAuth auth = FirebaseAuth.instance;

FirebaseStorage storage = FirebaseStorage.instance;

FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

FirebaseAnalyticsObserver observer =
FirebaseAnalyticsObserver(analytics: analytics);
