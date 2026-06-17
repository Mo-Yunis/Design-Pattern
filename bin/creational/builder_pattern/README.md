# 🏗️ Builder Pattern — نمط البناء

> **Creational Pattern** | بناء كائنات معقدة خطوة بخطوة

---

## 📌 ما هو نمط البناء؟ — What is the Builder Pattern?

نمط البناء هو **نمط تصميمي إنشائي** بيسمح لك تبني كائنات معقدة خطوة بخطوة،
بدل ما تحط كل الـ options في constructor واحد كبير.

> Builder is a **creational design pattern** that lets you construct complex
> objects step by step. It separates the construction of an object from its
> representation.

---

## 🎯 المشكلة اللي بيحلها — The Problem It Solves

تخيل إنك بتطلب بيتزا، عندها خيارات كتير:

```
Pizza(size, cheese, pepperoni, mushrooms, olives, onions, crustType, extraCheese)
//  ☝️ Constructor من الجحيم — Telescoping Constructor problem
```

- **7+ parameters** اختيارية → صعب تتذكر الترتيب
- بعضها مش مطلوب دايماً → بتبعت `null` أو `false` في كل مرة
- **الحل** = Builder Pattern ✅

---

## 🗂️ هيكل الملفات — File Structure

```
builder_pattern/
│
├── product_builder.dart   ← 📦 PART 1: المنتج     (Pizza class)
├── builder.dart           ← 🔧 PART 2: البناء     (PizzaBuilder class)
├── director.dart          ← 🎬 PART 3: المخرج     (PizzaDirector class)
├── builder_main.dart      ← 🚀 PART 4: الاستخدام  (main + 6 examples)
└── digrams.dart           ← 📊 مخطط العلاقات      (ASCII diagram)
```

---

## 🧩 المكونات الأساسية — Core Components

### 1️⃣ `product_builder.dart` — المنتج (Product)

الكائن المعقد اللي إحنا عايزين نبنيه.

```dart
class Pizza {
  final String size;       // مطلوب
  final bool cheese;       // اختياري — default: false
  final bool pepperoni;    // اختياري — default: false
  final String crustType;  // اختياري — default: 'thin'
  // ...

  // ⭐ Named constructor — الاتفاقية: "استخدم Builder فقط"
  const Pizza.create({required this.size, ...});
}
```

> **لماذا `Pizza.create()` وليس `Pizza._()` ؟**
>
> في Dart، الـ `_` بتعمل **file-private** (library-private) وليس class-private.
> يعني لو عرّفنا `Pizza._()` في `product_builder.dart`، الملف `builder.dart` **مش هيشوفها** لأنهم ملفان مختلفان.
>
> الحل: `Pizza.create()` — named constructor بيعبّر بوضوح إن "الـ Builder هو اللي يستدعيها"
> بدون الاعتماد على cross-file private access.

---

### 2️⃣ `builder.dart` — البناء (Builder)

بيبني البيتزا خطوة بخطوة ويرجع `this` لتسلسل الطرق (method chaining).

```dart
class PizzaBuilder {
  String _size = 'medium';  // قيمة افتراضية
  bool _cheese = false;
  // ...

  PizzaBuilder setSize(String size) {
    _size = size;
    return this; // 🔑 ترجع نفسها للتسلسل
  }

  PizzaBuilder addCheese() {
    _cheese = true;
    return this;
  }

  // ✅ الطريقة الأهم — بتتحقق وبتبني المنتج النهائي
  Pizza build() {
    if (_size.isEmpty) throw Exception('Pizza must have a size!');
    if (!['small', 'medium', 'large'].contains(_size)) {
      throw Exception('Invalid size!');
    }
    return Pizza._(...);  // ينشئ البيتزا بالبيانات المجمّعة
  }
}
```

---

### 3️⃣ `director.dart` — المخرج (Director)

**اختياري!** بيوفر وصفات جاهزة بدل ما المستخدم يبني من الصفر.

```dart
class PizzaDirector {
  final PizzaBuilder builder;
  PizzaDirector(this.builder);

  Pizza makeVegetarianPizza() {  // وصفة نباتية جاهزة
    return builder
      ..setSize('medium')
      ..addCheese()
      ..addMushrooms()
      .build(); // ✅ نقطة واحدة هنا — مش نقطتين!
  }
}
```

---

### 4️⃣ `builder_main.dart` — الاستخدام (Usage)

٦ أمثلة عملية تغطي كل سيناريوهات الاستخدام:

| المثال | الوصف |
|--------|-------|
| Example 1 | بناء يدوي مباشر بدون Director |
| Example 2 | استخدام Director مع وصفات جاهزة |
| Example 3 | وصفة مخصصة عبر Director |
| Example 4 | Method chaining بالطريقة الأكثر شيوعاً |
| Example 5 | اختبار الـ Validation (حجم غير صحيح / فارغ) |
| Example 6 | إعادة استخدام نفس البناء لبيتزا متعددة |

---

## ⚠️ أهم نقطة في Dart — Critical Dart Gotcha

### الفرق بين `.` و `..` (Cascade Operator)

```dart
// ❌ غلط — ..build() يرجع PizzaBuilder وليس Pizza!
final pizza = PizzaBuilder()
  ..setSize('large')
  ..addCheese()
  ..build();  // ← النتيجة: PizzaBuilder (مش البيتزا!)

// ✅ صح — .build() يرجع Pizza
final pizza = PizzaBuilder()
  ..setSize('large')   // ← cascade: يرجع Builder
  ..addCheese()        // ← cascade: يرجع Builder
  .build();            // ← dot: يرجع Pizza ✅
```

> **القاعدة:**
> - `..method()` = **cascade** → يرجع الكائن الأصلي (Builder)
> - `.method()` = **dot** → يرجع قيمة الطريقة نفسها (Pizza)
>
> استخدم `..` للـ setters و `.` للـ `build()`.

---

## ⚠️ تنبيه: Builder لا يُعاد تعيينه — Builder State Persists

```dart
final builder = PizzaBuilder();

// بيتزا أولى
final pizzaA = builder..setSize('small')..addCheese().build();

// ⚠️ pizzaB ستحتوي على الجبن من pizzaA لأن Builder لم يُعاد تهيئته!
final pizzaB = builder..setSize('large')..addPepperoni().build();
// pizzaB: large + pepperoni + cheese (من السابق!)

// ✅ الحل: أنشئ Builder جديداً في كل مرة
final pizzaC = PizzaBuilder()..setSize('large')..addPepperoni().build();
```

---

## 🔄 مخطط العلاقات — Class Diagram

```
┌──────────────┐         ┌─────────────────┐
│    Pizza     │◄────────│   PizzaBuilder  │
├──────────────┤  builds ├─────────────────┤
│ - size       │         │ - _size         │
│ - cheese     │         │ - _cheese       │
│ - pepperoni  │         │ + setSize()     │
│ - mushrooms  │         │ + addCheese()   │
│ - crustType  │         │ + addPepperoni()│
│ + describe() │         │ + build() → 🍕  │
└──────────────┘         └─────────────────┘
                                  ▲
                                  │ uses
                         ┌────────┴────────┐
                         │  PizzaDirector  │
                         ├─────────────────┤
                         │ + makeVeggies() │
                         │ + makeMeat()    │
                         │ + makeCheese()  │
                         │ + makeCustom()  │
                         └─────────────────┘
```

---

## ✅ متى تستخدم Builder Pattern؟

| الحالة | استخدم Builder؟ |
|--------|----------------|
| الكلاس عنده ٧+ parameters اختيارية | ✅ نعم |
| محتاج validation قبل إنشاء الكائن | ✅ نعم |
| عايز كائن **immutable** (لا يتغير بعد الإنشاء) | ✅ نعم |
| عندك "وصفات" / تكوينات جاهزة مختلفة | ✅ نعم (أضف Director) |
| الكلاس بسيط وعنده ٢-٣ parameters | ❌ لا، استخدم constructor عادي |

---

## 🆚 مقارنة مع Patterns تانية

| Pattern | الفرق |
|---------|-------|
| **Factory Method** | ينشئ نوع واحد من الكائنات دفعة واحدة |
| **Abstract Factory** | ينشئ عائلة من الكائنات المترابطة |
| **Builder** ✅ | ينشئ كائن واحد معقد **خطوة بخطوة** |

---

## 🚀 كيفية التشغيل — How to Run

```bash
dart bin/creational/builder_pattern/builder_main.dart
```

---

*Builder Pattern — Creational Patterns Series* 🏗️
