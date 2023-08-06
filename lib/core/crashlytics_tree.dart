import 'package:fimber/fimber.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsTree extends LogTree {
  // Only report Warnings and Errors.
  static const List<String> defaultLevels = ['W', 'E'];

  @override
  void log(
    String level,
    String message, {
    String? tag,
    dynamic ex,
    StackTrace? stacktrace,
  }) {
    FirebaseCrashlytics.instance.log(message);
    FirebaseCrashlytics.instance
        .recordError(ex ?? Exception(message), stacktrace);
  }

  @override
  List<String> getLevels() => defaultLevels;
}
