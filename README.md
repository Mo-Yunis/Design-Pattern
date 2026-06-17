# 🎨 Design Patterns in Dart — أنماط التصميم بـ Dart

> مشروع تعليمي يشرح أنماط التصميم بشكل عملي بأمثلة واقعية وكومنتات ثنائية (عربي/إنجليزي)

---

## 📚 ما هي أنماط التصميم؟ — What are Design Patterns?

أنماط التصميم هي **حلول جاهزة ومُجرَّبة** لمشاكل شائعة في تصميم البرمجيات.
مش كود جاهز تنسخه، لكن **خريطة** تساعدك تحل المشكلة بطريقة صحيحة.

> Design patterns are **reusable solutions** to commonly occurring problems
> in software design. They are blueprints, not copy-paste code.

---

## 🗂️ الأنماط الموجودة — Available Patterns

### 🏗️ Creational Patterns — أنماط الإنشاء ✅ مكتملة

> تهتم بكيفية **إنشاء الكائنات** بطريقة مرنة وقابلة للتوسع.

| # | النمط | المجلد | الفكرة الأساسية | المثال المستخدم |
|---|-------|--------|----------------|----------------|
| 1 | [🔒 Singleton](bin/creational/singleton_pattern/README.md) | `singleton_pattern/` | instance واحدة للكلاس في كل التطبيق | Logger |
| 2 | [🏭 Factory](bin/creational/factory_pattern/README.md) | `factory_pattern/` | إنشاء كائنات بدون تحديد الكلاس | Payment Methods |
| 3 | [🏗️ Builder](bin/creational/builder_pattern/README.md) | `builder_pattern/` | بناء كائنات معقدة خطوة بخطوة | Pizza Order |
| 4 | [🧬 Prototype](bin/creational/prototype_pattern/README.md) | `prototype_pattern/` | استنساخ كائنات موجودة بدلاً من إنشائها | Game Characters |

---

## 🔍 مقارنة سريعة — Quick Comparison

```
متى تستخدم أي نمط؟ / When to use which pattern?

┌──────────────────────────────────────────────────────────┐
│                   اسئل نفسك / Ask yourself              │
│                                                          │
│  محتاج instance واحدة فقط في التطبيق؟                   │
│  Need only ONE instance across the app?                  │
│                ↓ YES → 🔒 SINGLETON                      │
│                                                          │
│  عايز تنشئ كائن بس مش عارف النوع مسبقاً؟                │
│  Want to create object but don't know type upfront?      │
│                ↓ YES → 🏭 FACTORY                        │
│                                                          │
│  عايز تبني كائن معقد بإعدادات كتير؟                     │
│  Building complex object with many configurations?       │
│                ↓ YES → 🏗️ BUILDER                        │
│                                                          │
│  عندك كائن موجود وتحتاج نسخ منه بسرعة؟                  │
│  Have an existing object and need fast copies of it?     │
│                ↓ YES → 🧬 PROTOTYPE                      │
└──────────────────────────────────────────────────────────┘
```

---

## 📖 دليل كل نمط — Pattern Guides

### [🔒 Singleton Pattern](bin/creational/singleton_pattern/README.md)

**الفكرة:** ضمان إن الكلاس هيتعمل منه object واحد فقط

```dart
var logger1 = SingletonPatternForLogger();
var logger2 = SingletonPatternForLogger();
print(identical(logger1, logger2)); // true — نفس الكائن!
```

📁 [`singleton_pattern/`](bin/creational/singleton_pattern/)

---

### [🏭 Factory Pattern](bin/creational/factory_pattern/README.md)

**الفكرة:** المصنع يقرر أي نوع ينشئ — العميل يعرف بس الواجهة

```dart
PaymentMethod p = PaymentFactory.create('credit');
p.pay(100.0); // CreditCardPayment.pay() — Polymorphism!
```

📁 [`factory_pattern/`](bin/creational/factory_pattern/)

---

### [🏗️ Builder Pattern](bin/creational/builder_pattern/README.md)

**الفكرة:** بناء كائن معقد خطوة بخطوة بدل constructor كبير

```dart
final pizza = PizzaBuilder()
    .setSize('large')
    .addCheese()
    .addPepperoni()
    .setCrustType('thin')
    .build();
```

📁 [`builder_pattern/`](bin/creational/builder_pattern/)

---

### [🧬 Prototype Pattern](bin/creational/prototype_pattern/README.md)

**الفكرة:** استنساخ كائن موجود بدلاً من إنشائه من الصفر — مع ضمان الـ Deep Copy

```dart
final warrior = GameCharacter(name: 'Aric', health: 200, skills: ['Shield Bash']);

// نسخة مطابقة مستقلة تماماً
final clone   = warrior.clone();

// نسخة معدَّلة — نفس أسلوب Flutter's copyWith!
final elite   = warrior.copyWith(name: 'Elite Aric', attackPower: 150);

// أو عبر Registry — نماذج جاهزة مسبقاً
final registry = CharacterRegistry();
registry.register('warrior', warrior);
final player1 = registry.get('warrior'); // دائماً يرجع clone ✅
```

📁 [`prototype_pattern/`](bin/creational/prototype_pattern/)

---

## ⚡ Dart-Specific Notes — ملاحظات خاصة بـ Dart

### 1. Library Privacy (`_` prefix)

```dart
// في Dart، `_` تعني FILE-private (ملف-private)
// مش class-private زي Java أو C#
_instance // ← مرئي داخل نفس الملف فقط
```

### 2. `factory` Constructor

```dart
// Dart يدعم factory constructors — تُرجع instance موجودة
factory MyClass() => _instance ??= MyClass._internal();
```

### 3. Dot Chaining vs Cascade

```dart
// للـ Builder Pattern — استخدم dot chaining (.) مش cascade (..)
// لأن (..) تُرجع نوع الكائن الأصلي دايماً

final pizza = PizzaBuilder()
    .setSize('large')  // (.) ← كل setter يرجع PizzaBuilder
    .addCheese()       // (.) ← تسلسل يكمل
    .build();          // (.) ← يرجع Pizza ✅

// ❌ لو استخدمت (..) هيرجع PizzaBuilder مش Pizza
```

### 4. Deep Copy for Collections (Prototype)

```dart
// ❌ Shallow Copy — مشاركة نفس القائمة (خطر!)
GameCharacter clone() => GameCharacter(skills: skills); // نفس المرجع!

// ✅ Deep Copy — قائمة مستقلة جديدة
GameCharacter clone() => GameCharacter(skills: List.from(skills)); // آمن ✅

// نفس المبدأ في Flutter:
final style2 = style1.copyWith(fontSize: 18); // TextStyle deep copies internally
```

---

## 🚀 كيفية التشغيل — How to Run

```bash
# 🔒 Singleton
dart bin/creational/singleton_pattern/singletom_main.dart

# 🏭 Factory
dart bin/creational/factory_pattern/factory_main.dart

# 🏗️ Builder
dart bin/creational/builder_pattern/builder_main.dart

# 🧬 Prototype
dart bin/creational/prototype_pattern/prototype_main.dart
```

---

## 📐 هيكل المشروع — Project Structure

```
desginpattern/
│
├── bin/
│   └── creational/
│       ├── singleton_pattern/
│       │   ├── singleton_pattern.dart   ← التطبيق
│       │   ├── singletom_main.dart      ← الاستخدام
│       │   └── README.md                ← 📖 الشرح
│       │
│       ├── factory_pattern/
│       │   ├── base_interface.dart      ← الواجهات والمنتجات
│       │   ├── factory_class.dart       ← المصنع
│       │   ├── factory_main.dart        ← الاستخدام
│       │   ├── digrams.dart             ← المخططات
│       │   └── README.md                ← 📖 الشرح
│       │
│       ├── builder_pattern/
│       │   ├── product_builder.dart     ← المنتج (Pizza)
│       │   ├── builder.dart             ← البناء (PizzaBuilder)
│       │   ├── director.dart            ← المخرج (PizzaDirector)
│       │   ├── builder_main.dart        ← الاستخدام (6 أمثلة)
│       │   ├── digrams.dart             ← المخططات
│       │   └── README.md                ← 📖 الشرح
│       │
│       └── prototype_pattern/
│           ├── prototype_interface.dart ← الواجهة + GameCharacter
│           ├── prototype_registry.dart  ← الـ Registry
│           ├── prototype_main.dart      ← الاستخدام (5 أمثلة)
│           ├── diagrams.dart            ← المخططات
│           └── README.md                ← 📖 الشرح
│
├── pubspec.yaml
└── README.md                            ← 📖 هذا الملف
```

---

---

## 🗺️ خارطة الطريق — Roadmap

| الفئة | الحالة | الأنماط |
|-------|--------|---------|
| 🏗️ **Creational** | ✅ مكتملة | Singleton · Factory · Builder · Prototype |
| 🏛️ **Structural** | 🔜 قريباً | Adapter · Decorator · Facade · Proxy · Composite · Bridge · Flyweight |
| 🔄 **Behavioral** | 🔜 قريباً | Observer · Strategy · Command · Iterator · State · Template · Chain of Responsibility |

---

*Design Patterns in Dart — Creational Series Complete* 🎨
