/// ============================================================
/// Singleton Pattern Implementation for Logger
/// ============================================================

/// This class implements the Singleton design pattern to ensure
/// only ONE instance of the logger exists throughout the application
class SingletonPatternForLogger {

  // ------------------------------------------------------------------
  // 1. Static Instance (Lazy Initialization)
  // ------------------------------------------------------------------
  /// Private static instance of the same class
  /// The 'static' keyword means this belongs to the class itself, not to instances
  /// The '?' makes it nullable - initially null (not created yet)
  /// This is called "lazy initialization" because we create the instance
  /// only when it's first needed, not at program startup
  /// 
  /// (Arabic): متغير ثابت من نفس الكلاس
  /// يتم التهيئة بشكل كسول (عند الحاجة فقط وليس عند بدء التشغيل)
  static SingletonPatternForLogger? _instance;

  // ------------------------------------------------------------------
  // 2. Private Logger Instance
  // ------------------------------------------------------------------
  /// Private instance of the actual logger class
  /// The '_' prefix makes it library-private (accessible only inside this file)
  /// This follows the principle of encapsulation - hiding implementation details
  /// 
  /// (Arabic): كائن خاص من كلاس اللوجر الحقيقي
  /// لا يمكن الوصول إليه إلا من داخل هذا الملف فقط
  late _Logger logger;

  // ------------------------------------------------------------------
  // 3. Private Constructor
  // ------------------------------------------------------------------
  /// Private named constructor (starts with '_')
  /// Cannot be called from outside this class
  /// This is the key to the Singleton pattern - prevents direct instantiation
  /// Initializes the internal logger when the Singleton instance is created
  /// 
  /// (Arabic): كونستركتور خاص لا يمكن استدعاؤه من خارج الكلاس
  /// هذا يضمن عدم إنشاء أكثر من اوبجكت واحد
  SingletonPatternForLogger._internal() {
    logger = _Logger();
  }

  // ------------------------------------------------------------------
  // 4. Factory Constructor
  // ------------------------------------------------------------------
  /// Factory constructor that returns the single instance
  /// 'factory' means this constructor doesn't always create a new instance
  /// The null-aware operator '??=' assigns a new value ONLY if it's null
  /// This implements the logic: if instance exists, return it; otherwise create it
  /// 
  /// (Arabic): فاكتوري كونستركتور - لا ينشئ اوبجكت جديد دائماً
  /// إما يعيد الاوبجكت الموجود أو ينشئ واحد جديد إذا كان لا يوجد
  factory SingletonPatternForLogger() =>
      _instance ??= SingletonPatternForLogger._internal();
}

/// ============================================================
/// Internal Logger Class (Single Responsibility Principle)
/// ============================================================

/// This class is separated following the SINGLE RESPONSIBILITY PRINCIPLE (SRP)
/// from SOLID principles: "Each class should have only one reason to change"
/// 
/// Arabic: هذا الكلاس منفصل لوحده لتطبيق مبدأ "المسؤولية الواحدة"
/// من مبادئ SOLID - كل كلاس له وظيفة واحدة محددة فقط
/// 
/// The underscore '_' makes it library-private - only accessible within this file
/// This is good encapsulation - hiding implementation details from external code
class _Logger {

  /// Internal list to store log messages
  /// '_' prefix makes it private to this class
  /// 
  /// (Arabic): لستة داخلية لتخزين رسائل اللوج
  List _logs = [];

  /// Add a new log message to the list
  /// 
  /// (Arabic): دالة لإضافة رسالة جديدة إلى اللستة
  void addLog(String log) {
    _logs.add(log);
  }

  ///get logs
  List logs()=>_logs;
  /// (Optional) Remove a log at specific index
  void removeLogAt(int index) {
    if (index >= 0 && index < _logs.length) {
      _logs.removeAt(index);
    }
  }
}