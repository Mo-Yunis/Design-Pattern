# 🔒 Singleton Pattern — نمط المفرد

> **Creational Pattern** | ضمان وجود instance واحدة فقط في التطبيق

---

## 📌 ما هو نمط المفرد؟ — What is the Singleton Pattern?

نمط المفرد هو **نمط تصميمي إنشائي** بيضمن إن الكلاس هيتعمل منه **instance واحدة فقط** طول فترة تشغيل التطبيق، وبيوفر نقطة وصول عالمية لها.

> Singleton is a **creational design pattern** that ensures a class has **only one instance**
> throughout the application lifetime, and provides a global access point to it.

---

## 🎯 المشكلة اللي بيحلها — The Problem It Solves

```dart
// ❌ بدون Singleton — كل استدعاء ينشئ logger جديد منفصل!
var logger1 = Logger();
var logger2 = Logger();

logger1.addLog("User logged in");
print(logger2.logs()); // [] ← فارغ! logger2 مش نفس logger1

// ✅ مع Singleton — نفس الـ instance دايماً
var logger1 = SingletonPatternForLogger();
var logger2 = SingletonPatternForLogger();

logger1.logger.addLog("User logged in");
print(logger2.logger.logs()); // ["User logged in"] ← نفس البيانات!
print(identical(logger1, logger2)); // true ← نفس الكائن
```

**أمثلة حقيقية تحتاج Singleton:**
- 📝 Logger (تسجيل الأحداث)
- ⚙️ App Configuration / الإعدادات
- 🗄️ Database Connection Pool
- 🌐 HTTP Client
- 🔔 Notification Manager

---

## 🗂️ هيكل الملفات — File Structure

```
singleton_pattern/
│
├── singleton_pattern.dart   ← 🔒 التطبيق الكامل  (Singleton + Logger)
└── singletom_main.dart      ← 🚀 الاستخدام        (Demo)
```

---

## 🧩 المكونات الأساسية — Core Components

### 1️⃣ `singleton_pattern.dart` — التطبيق الكامل

**الكلاس الرئيسي (Singleton):**

```dart
class SingletonPatternForLogger {

  // ─── الخطوة 1: Static nullable instance ───────────────────────
  // static: تنتمي للكلاس نفسه، مش لأي instance
  // ?: قابلة للـ null في البداية (Lazy Initialization)
  static SingletonPatternForLogger? _instance;

  // ─── الخطوة 2: الكائن الداخلي ────────────────────────────────
  late _Logger logger;

  // ─── الخطوة 3: Private Named Constructor ─────────────────────
  // _internal: لا يمكن استدعاؤه من خارج الكلاس
  // هذا يمنع أي حد يعمل SingletonPatternForLogger() عادي
  SingletonPatternForLogger._internal() {
    logger = _Logger(); // ينشئ الـ logger مرة واحدة فقط
  }

  // ─── الخطوة 4: Factory Constructor ───────────────────────────
  // factory: لا ينشئ instance جديدة دايماً
  // ??=: لو _instance == null → أنشئها، لو موجودة → أرجعها
  factory SingletonPatternForLogger() =>
      _instance ??= SingletonPatternForLogger._internal();
}
```

**الكلاس الداخلي (Logger):**

```dart
// _ في بداية الاسم: library-private (ملف-private في Dart)
// مش ممكن تستخدمه من ملف تاني — Single Responsibility Pattern
class _Logger {
  List _logs = [];

  void addLog(String log) => _logs.add(log);
  List logs() => _logs;
  void removeLogAt(int index) {
    if (index >= 0 && index < _logs.length) _logs.removeAt(index);
  }
}
```

---

### 2️⃣ `singletom_main.dart` — الاستخدام

```dart
void main() {
  var logger1 = SingletonPatternForLogger(); // ← ينشئ instance جديدة
  var logger2 = SingletonPatternForLogger(); // ← يرجع نفس الـ instance

  print(identical(logger1, logger2)); // true ✅

  logger1.logger.addLog("Application started");
  logger1.logger.addLog("User logged in");
  logger2.logger.addLog("Data saved");

  print(logger1.logger.logs()); // ["Application started", "User logged in", "Data saved"]
  print(logger2.logger.logs().length); // 3 ✅ — نفس البيانات!
}
```

---

## 🔄 مخطط العلاقات — Class Diagram

```
┌──────────────────────────────────────┐
│       SingletonPatternForLogger      │
│ ────────────────────────────────── ──│
│ - _instance: static? (class-level)  │
│ + logger: _Logger                    │
│ ────────────────────────────────────│
│ - _internal()  ← private constructor│
│ + factory()    ← returns _instance  │
└──────────────────┬───────────────────┘
                   │ owns
           ┌───────┴──────────┐
           │    _Logger       │
           │ ─────────────────│
           │ - _logs: List    │
           │ + addLog()       │
           │ + logs()         │
           │ + removeLogAt()  │
           └──────────────────┘

                  ↓ usage
┌────────┐   ┌────────┐
│logger1 ├──►│        │◄──┤logger2 │
└────────┘   │ SAME   │   └────────┘
             │instance│
             └────────┘
```

---

## 🔑 المفاهيم الأساسية — Key Concepts

### `factory` Constructor في Dart

```dart
// factory = constructor يمكنه إرجاع instance موجودة بدلاً من إنشاء جديدة
factory SingletonPatternForLogger() =>
    _instance ??= SingletonPatternForLogger._internal();
//                ↑ null-coalescing assignment:
//                  لو _instance == null → اعمل _internal() وخزّنها
//                  لو _instance != null → أرجعها كما هي
```

### Lazy Initialization — التهيئة الكسولة

```dart
static SingletonPatternForLogger? _instance; // null في البداية

// الـ instance لا تُنشأ حتى أول استدعاء فعلي
// هذا يوفر الذاكرة إذا لم يُستخدم الـ Singleton أبداً
```

### `identical()` في Dart

```dart
// identical() يتحقق إن المتغيرين يشيران لنفس الكائن في الذاكرة
// (ليس فقط أن قيمهما متساوية)
print(identical(logger1, logger2)); // true = نفس العنوان في الذاكرة
```

---

## ⚠️ تنبيهات مهمة — Important Gotchas

### 1. Singleton و Multithreading (مش مشكلة في Dart)

```dart
// ✅ Dart يعمل على Single Thread (Event Loop)
// لذلك Singleton آمن تلقائياً في Dart/Flutter
// بخلاف Java/C++ حيث تحتاج Mutex/Lock
```

### 2. تجنب Singleton للـ State القابل للتغيير

```dart
// ⚠️ حذار: Singleton يجعل الـ State عالمي (Global State)
// → صعب في الـ Testing (تحتاج reset بين كل test)
// → يخلق coupling مخفي بين أجزاء التطبيق
// ✅ استخدمه للـ services التي لها مصدر بيانات واحد فعلاً
```

---

## ✅ متى تستخدم Singleton Pattern؟

| الحالة | استخدم Singleton؟ |
|--------|------------------|
| Logger / سجل أحداث التطبيق | ✅ نعم |
| App Config / إعدادات عامة | ✅ نعم |
| Database connection pool | ✅ نعم |
| Service بيانات مشتركة في كل التطبيق | ✅ نعم |
| كلاس عادي بيانات محددة | ❌ لا |
| UI Widgets / State محلي | ❌ لا |

---

## 🆚 مقارنة مع Patterns تانية

| Pattern | الفرق |
|---------|-------|
| **Singleton** ✅ | instance واحدة في التطبيق كله |
| **Factory** | ينشئ instances متعددة من types مختلفة |
| **Builder** | يبني كائن معقد خطوة بخطوة |

---

## 🚀 كيفية التشغيل — How to Run

```bash
dart bin/creational/singleton_pattern/singletom_main.dart
```

**المخرجات المتوقعة:**
```
true
[Application started, User logged in, Data saved]
3
```

---

## 💡 Singleton في Flutter — Real World Usage

```dart
// مثال عملي: App Config كـ Singleton
class AppConfig {
  static AppConfig? _instance;
  late String baseUrl;
  late String apiKey;

  AppConfig._internal() {
    baseUrl = 'https://api.example.com';
    apiKey  = 'my-secret-key';
  }

  factory AppConfig() => _instance ??= AppConfig._internal();
}

// في أي مكان في التطبيق:
final config = AppConfig();
print(config.baseUrl); // دايماً نفس الـ config
```

---

*Singleton Pattern — Creational Patterns Series* 🔒
