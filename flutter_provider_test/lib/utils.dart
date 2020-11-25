import 'package:logger/logger.dart';

class Log{
  static final logger = Logger(printer: PrettyPrinter(colors: true));

  static void d(message) {
    return logger.d(message);
  }

  static void error(message) {
    return logger.e(message);
  }

  static void info(message) {
    return logger.i(message);
  }

  static void warning(message) {
    return logger.w(message);
  }
}