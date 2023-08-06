import 'dart:async';

import 'package:fimber/fimber.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/config.dart';
import 'package:weather/ui/weather_app.dart';

import 'firebase_options.dart';

main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool isProd = Config.getFlavor() == Flavor.prod;

    if (!kReleaseMode) {
      Fimber.plantTree(DebugTree());
    }

    await _initFirebase(isProd);

    runApp(const WeatherApp());
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}

Future<void> _initFirebase(bool isProd) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(isProd);
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.setAnalyticsCollectionEnabled(isProd);

  await analytics.logAppOpen();
}
