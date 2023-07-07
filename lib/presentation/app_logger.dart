import 'package:logger/logger.dart';

Logger get logger => AppLogger.instance;

class AppLogger extends Logger {
  AppLogger._()
      : super(
          printer: PrettyPrinter(
            methodCount: 2,
            errorMethodCount: 8,
            lineLength: 120,
            colors: true,
            printEmojis: true,
            printTime: false,
          ),
        );

  static final instance = AppLogger._();
}
