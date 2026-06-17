# 🏭 Factory Pattern — نمط المصنع

> **Creational Pattern** | إنشاء كائنات بدون تحديد الكلاس الفعلي

---

## 📌 ما هو نمط المصنع؟ — What is the Factory Pattern?

نمط المصنع هو **نمط تصميمي إنشائي** بيوفر طريقة لإنشاء الكائنات بدون ما الكود العميل يعرف الكلاس الفعلي اللي بيتنشئ.

> Factory Pattern is a **creational design pattern** that provides a way to
> create objects **without specifying the exact class** of object that will be created.

---

## 🎯 المشكلة اللي بيحلها — The Problem It Solves

```dart
// ❌ بدون factory — العميل مرتبط بكلاسات محددة
if (type == 'credit') {
  final p = CreditCardPayment(); // مرتبط بالتفاصيل
  p.pay(100);
} else if (type == 'paypal') {
  final p = PayPalPayment();     // مرتبط بالتفاصيل
  p.pay(100);
}
// ➕ لو أضفنا CryptoPayment؟ لازم نغير كل كود العميل!

// ✅ مع factory — العميل يعرف بس الواجهة
final p = PaymentFactory.create('credit');
p.pay(100);
// ➕ إضافة CryptoPayment؟ تغيير في مكان واحد فقط ✅
```

---

## 🗂️ هيكل الملفات — File Structure

```
factory_pattern/
│
├── base_interface.dart   ← 🎯 PART 1: الواجهة والمنتجات  (PaymentMethod + Implementations)
├── factory_class.dart    ← 🏭 PART 2: المصنع             (PaymentFactory)
├── factory_main.dart     ← 🚀 PART 3: الاستخدام          (Client Code)
└── digrams.dart          ← 📊 مخطط العلاقات              (ASCII diagrams)
```

---

## 🧩 المكونات الأساسية — Core Components

### 1️⃣ `base_interface.dart` — الواجهة والمنتجات

**أولاً: الواجهة المجردة (Abstract Interface)**

```dart
abstract class PaymentMethod {
  void pay(double amount); // العقد الذي يجب أن تنفذه كل الفئات
}
```

**ثانياً: المنتجات الفعلية (Concrete Products)**

```dart
class CreditCardPayment implements PaymentMethod {
  @override
  void pay(double amount) => print('Paid $amount using Credit Card');
}

class PayPalPayment implements PaymentMethod {
  @override
  void pay(double amount) => print('Paid $amount using PayPal');
}
```

> **مبدأ مهم:** العميل يعرف فقط `PaymentMethod` — لا يعرف `CreditCardPayment` أو `PayPalPayment`.
> هذا يسمى **"البرمجة نحو الواجهة"** وليس نحو التنفيذ.

---

### 2️⃣ `factory_class.dart` — المصنع (Factory)

```dart
class PaymentFactory {
  // static: نستدعيها بدون إنشاء instance من PaymentFactory
  static PaymentMethod create(String type) {
    switch (type.toLowerCase()) {
      case 'credit': return CreditCardPayment(); // يقرر هو!
      case 'paypal': return PayPalPayment();     // يقرر هو!
      default: throw Exception('Unknown payment type: $type');
    }
  }
}
```

> **المصنع هو اللي يقرر** أي كلاس يُنشئ — مش كود العميل.

---

### 3️⃣ `factory_main.dart` — الاستخدام (Client Code)

```dart
// العميل يطلب، والمصنع يقرر
PaymentMethod payment = PaymentFactory.create('credit');
payment.pay(100.0);  // ← Polymorphism: CreditCardPayment.pay() يُنفَّذ

PaymentMethod another = PaymentFactory.create('paypal');
another.pay(50.0);   // ← Polymorphism: PayPalPayment.pay() يُنفَّذ
```

---

## 🔄 مخطط العلاقات — Class Diagram

```
           ┌────────────────┐
           │  PaymentMethod │  ← Abstract Interface
           │ ───────────────│
           │ + pay(amount)  │
           └────────┬───────┘
                    │ implements
         ┌──────────┴──────────┐
         │                     │
┌────────┴────────┐   ┌────────┴────────┐
│ CreditCardPaymt │   │  PayPalPayment  │
│ ────────────────│   │ ────────────────│
│ + pay(amount)   │   │ + pay(amount)   │
└─────────────────┘   └─────────────────┘
         ▲                     ▲
         │      creates        │
         └──────┬──────────────┘
         ┌──────┴──────────┐
         │  PaymentFactory │
         │ ────────────────│
         │ + create(type)  │  ← Static Factory Method
         └─────────────────┘
                 ▲
                 │ calls
         ┌───────┴───────┐
         │  Client Code  │  ← factory_main.dart
         └───────────────┘
```

---

## 🆚 الفرق: Static Method vs Factory Constructor في Dart

| الأسلوب | المثال | متى تستخدمه |
|---------|--------|-------------|
| **Static Factory Method** ✅ (مستخدم هنا) | `PaymentFactory.create('credit')` | كلاس مصنع منفصل |
| **Factory Constructor** | `PaymentMethod.create('credit')` | داخل الـ abstract class نفسه |

```dart
// الأسلوب البديل — factory constructor على الـ abstract class مباشرة
abstract class PaymentMethod {
  factory PaymentMethod.create(String type) {
    if (type == 'credit') return CreditCardPayment();
    return PayPalPayment();
  }
  void pay(double amount);
}
```

---

## ✅ فوائد النمط — Benefits

| الفائدة | الشرح |
|--------|-------|
| **Encapsulation** | منطق الإنشاء مخفي داخل المصنع |
| **Open/Closed Principle** | نضيف نوع جديد بدون تغيير كود العميل |
| **Single Responsibility** | المصنع مسؤول فقط عن إنشاء الكائنات |
| **Dependency Inversion** | العميل يعتمد على التجريد لا على التفاصيل |

---

## 📈 كيف نضيف نوع دفع جديد؟ — How to Extend

```dart
// 1. أضف الكلاس الجديد — Add new class
class CryptoPayment implements PaymentMethod {
  @override
  void pay(double amount) => print('Paid $amount using Crypto');
}

// 2. أضف case واحدة في المصنع — Add one case in factory
case 'crypto': return CryptoPayment();

// ✅ كود العميل لا يتغير أبداً!
// Client code never changes!
```

---

## ✅ متى تستخدم Factory Pattern؟

| الحالة | استخدم Factory؟ |
|--------|----------------|
| مش عارف مسبقاً أي نوع هتنشئ | ✅ نعم |
| عايز تفصل إنشاء الكائن عن استخدامه | ✅ نعم |
| عندك أنواع متعددة بنفس الواجهة | ✅ نعم |
| هتضيف أنواع جديدة في المستقبل | ✅ نعم |
| في كلاس واحد بس ومش هيتغير | ❌ لا |

---

## 🆚 مقارنة مع Patterns تانية

| Pattern | الفرق |
|---------|-------|
| **Factory Method** ✅ | ينشئ نوع واحد بناءً على input |
| **Abstract Factory** | ينشئ عائلات من الكائنات المترابطة |
| **Builder** | يبني كائن واحد معقد خطوة بخطوة |

---

## 🚀 كيفية التشغيل — How to Run

```bash
dart bin/creational/factory_pattern/factory_main.dart
```

**المخرجات المتوقعة:**
```
Paid 100.0 using Credit Card
Paid 50.0 using PayPal
```

---

*Factory Pattern — Creational Patterns Series* 🏭
