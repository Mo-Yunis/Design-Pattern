import 'singleton_pattern.dart';

void main() {
  // This will return the SAME instance every time
  // (Arabic): هذا الاستدعاء سيعيد نفس الاوبجكت في كل مرة
  var logger1 = SingletonPatternForLogger();
  var logger2 = SingletonPatternForLogger();

  // Both variables point to the same instance
  // (Arabic): كلا المتغيرين يشيران إلى نفس الكائن
  print(identical(logger1, logger2)); // Output: true

  // Adding logs
  logger1.logger.addLog("Application started");
  logger1.logger.addLog("User logged in");
  logger2.logger.addLog("Data saved");

  // Both instances share the same logs
  print(logger1.logger.logs()); // Shows all 3 logs
  print(logger2.logger.logs().length); // Output: 3
}