# 🧬 Prototype Pattern — نمط النموذج الأولي

> **Creational Pattern** | استنساخ الكائنات بدلاً من إنشائها من الصفر

---

## 📌 ما هو نمط النموذج الأولي؟ — What is the Prototype Pattern?

نمط النموذج الأولي هو **نمط تصميمي إنشائي** يسمح لك بنسخ كائنات موجودة بدلاً من إنشائها من الصفر، حتى لو كان الكود الخاص بك لا يعرف الكلاس الفعلي للكائن.

> Prototype is a **creational design pattern** that lets you copy existing
> objects instead of creating them from scratch, even when your code doesn't
> know the exact class of the object.

---

## 🎯 المشكلة اللي بيحلها — The Problem It Solves

```dart
// ❌ بدون Prototype — إنشاء متكرر من الصفر
final boss1 = GameCharacter(
  name: 'Dragon Boss',
  characterClass: 'Dragon',
  health: 5000,
  attackPower: 300,
  defense: 200,
  skills: ['Fire Breath', 'Tail Sweep', 'Wing Gust', 'Roar'],
);
// لو عندنا 100 boss → نكتب نفس الكود 100 مرة! ❌
// 100 bosses? Write the same code 100 times! ❌

// ✅ مع Prototype — نسخ فوري
final boss2 = boss1.clone(); // نسخة مستقلة في سطر واحد ✅
final boss3 = boss1.clone()..health = 3000; // نسخة معدّلة ✅
```

---

## 🗂️ هيكل الملفات — File Structure

```
prototype_pattern/
│
├── prototype_interface.dart  ← 🧬 PART 1: الواجهة والكائن  (Prototype + GameCharacter)
├── prototype_registry.dart   ← 🗄️ PART 2: الـ Registry      (CharacterRegistry)
├── prototype_main.dart       ← 🚀 PART 3: الاستخدام         (Client Code — 5 examples)
└── diagrams.dart             ← 📊 مخطط العلاقات             (ASCII diagrams)
```

---

## 🧩 المكونات الأساسية — Core Components

### 1️⃣ `prototype_interface.dart` — الواجهة والكائن

**أولاً: الواجهة المجردة (Abstract Prototype)**

```dart
abstract class Prototype<T> {
  T clone(); // العقد الإجباري — mandatory contract
}
```

**ثانياً: الكائن القابل للاستنساخ (Concrete Prototype)**

```dart
class GameCharacter implements Prototype<GameCharacter> {
  final String name;
  final String characterClass;
  int health;
  int attackPower;
  int defense;
  List<String> skills;

  // ⭐ الطريقة الجوهرية — The Core Method
  @override
  GameCharacter clone() {
    return GameCharacter(
      name: name,
      characterClass: characterClass,
      health: health,
      attackPower: attackPower,
      defense: defense,
      skills: List.from(skills), // ← Deep Copy للقائمة! ⚠️
    );
  }

  // تخصيص النسخة أثناء الاستنساخ — Customized clone
  GameCharacter copyWith({String? name, int? health, ...}) {
    return GameCharacter(
      name: name ?? this.name,
      health: health ?? this.health,
      // ...
    );
  }
}
```

> **لماذا `List.from(skills)` وليس `skills` مباشرة؟**
>
> - **Shallow Copy** = مشاركة نفس القائمة → تغيير النسخة يؤثر على الأصل! ⚠️
> - **Deep Copy** = قائمة منفصلة جديدة → كل كائن مستقل تماماً ✅

---

### 2️⃣ `prototype_registry.dart` — مستودع النماذج (Registry)

**اختياري!** يحفظ نماذج جاهزة مسبقاً ويوفرها عند الطلب.

```dart
class CharacterRegistry {
  final Map<String, GameCharacter> _prototypes = {};

  // يُضيف نموذجاً — adds a prototype
  void register(String key, GameCharacter character) {
    _prototypes[key] = character;
  }

  // يُعيد نسخة مستنسخة دائماً — always returns a clone!
  GameCharacter get(String key) {
    return _prototypes[key]!.clone(); // ← clone وليس المرجع الأصلي!
  }
}
```

> **المبدأ الأساسي:** الـ Registry يُخزِّن الأصل، لكن يُعطيك دائماً **نسخة**، ليس المرجع نفسه.

---

### 3️⃣ `prototype_main.dart` — الاستخدام (Usage)

٥ أمثلة عملية تغطي كل سيناريوهات الاستخدام:

| المثال | الوصف |
|--------|-------|
| Example 1 | استنساخ مباشر وإثبات استقلالية الكائنين |
| Example 2 | استخدام `copyWith` لإنشاء variant مخصص |
| Example 3 | استخدام الـ Registry لإنتاج شخصيات جاهزة |
| Example 4 | إثبات الـ Deep Copy عملياً على القوائم |
| Example 5 | مقارنة أداء الإنشاء العادي vs الاستنساخ |

---

## ⚠️ أهم نقطة — Shallow Copy vs Deep Copy

```dart
// ❌ Shallow Copy — خطر على القوائم والكائنات المتداخلة!
GameCharacter shallowClone() {
  return GameCharacter(
    skills: skills, // ← نفس مرجع القائمة!
    // ...
  );
}

final original = GameCharacter(skills: ['Fireball']);
final clone = original.shallowClone();

clone.skills.add('Thunder'); // ⚠️ يؤثر على original أيضاً!
print(original.skills); // ['Fireball', 'Thunder'] — كارثة!

// ✅ Deep Copy — آمن تماماً
GameCharacter clone() {
  return GameCharacter(
    skills: List.from(skills), // ← قائمة جديدة مستقلة
    // ...
  );
}

clone.skills.add('Thunder'); // ✅ لا يؤثر على original
print(original.skills); // ['Fireball'] ← لم يتغير ✅
```

---

## 🔄 مخطط العلاقات — Class Diagram

```
┌──────────────────────┐
│   «interface»        │
│   Prototype<T>       │  ← Abstract contract
├──────────────────────┤
│ + clone() → T        │
└──────────┬───────────┘
           │ implements
           ▼
┌──────────────────────────────┐
│       GameCharacter          │  ← Concrete Prototype
├──────────────────────────────┤
│ - name          : String     │
│ - characterClass: String     │
│ - health        : int        │
│ - attackPower   : int        │
│ - defense       : int        │
│ - skills        : List       │
├──────────────────────────────┤
│ + clone()    → GameCharacter │  ← Deep copy
│ + copyWith() → GameCharacter │  ← Modified clone
│ + describe()                 │
└──────────────────────────────┘
           ▲
           │ stores & clones
┌──────────┴───────────────────┐
│      CharacterRegistry       │  ← Registry (optional)
├──────────────────────────────┤
│ - _prototypes: Map<String,…> │
├──────────────────────────────┤
│ + register(key, character)   │
│ + get(key) → GameCharacter   │  ← Always returns clone!
└──────────────────────────────┘
           ▲
           │ uses
┌──────────┴───────────┐
│    Client Code       │  ← prototype_main.dart
└──────────────────────┘
```

---

## 🆚 الفرق بين Clone و CopyWith في Dart

| الأسلوب | متى تستخدمه | مثال |
|---------|-------------|------|
| **`clone()`** ✅ (مستخدم هنا) | نسخة طبق الأصل بدون تغيير | `warrior.clone()` |
| **`copyWith()`** | نسخة مع تعديل بعض الحقول | `warrior.copyWith(health: 300)` |

```dart
// clone — نسخة مطابقة تماماً
final exactCopy = warrior.clone();

// copyWith — نسخة محسّنة
final boosted = warrior.copyWith(
  name: 'Elite Warrior',
  attackPower: 150,
);
```

> **ملاحظة دارت:** `copyWith` شائعة جداً في Flutter (مثل `TextStyle.copyWith`، `ThemeData.copyWith`). نفس المفهوم تماماً!

---

## ✅ فوائد النمط — Benefits

| الفائدة | الشرح |
|--------|-------|
| **Performance** | استنساخ أسرع من الإنشاء المتكرر للكائنات المعقدة |
| **Encapsulation** | منطق النسخ محصور داخل الكلاس نفسه |
| **Flexibility** | تنشئ variants مختلفة من نفس الأصل |
| **Decoupling** | الكود العميل لا يحتاج يعرف تفاصيل الإنشاء |

---

## 📈 حالات الاستخدام الحقيقية — Real-world Use Cases

```dart
// 1. لعبة فيديو — إنتاج أعداء متشابهين
final enemyPrototype = Enemy(type: 'Goblin', health: 100, drops: ['Gold', 'Sword']);
final wave = List.generate(20, (_) => enemyPrototype.clone()); // 20 goblin دفعة واحدة

// 2. Flutter — TextStyle.copyWith (نفس المبدأ!)
final baseStyle = TextStyle(fontSize: 16, color: Colors.black);
final boldStyle = baseStyle.copyWith(fontWeight: FontWeight.bold);

// 3. إعدادات — نسخ config للبيئات المختلفة
final devConfig = AppConfig(apiUrl: 'localhost', debug: true);
final prodConfig = devConfig.copyWith(apiUrl: 'api.myapp.com', debug: false);
```

---

## ✅ متى تستخدم Prototype Pattern؟

| الحالة | استخدم Prototype؟ |
|--------|-----------------|
| إنشاء الكائن مكلف (database call, complex init) | ✅ نعم |
| تحتاج variants كثيرة من نفس الكائن | ✅ نعم |
| الكائن عنده حالة تريد نسخها وتعديلها | ✅ نعم |
| في لعبة وتريد spawn عدد كبير من نفس العدو | ✅ نعم |
| الكائن بسيط وإنشاؤه لا يكلف شيئاً | ❌ لا، استخدم constructor عادي |

---

## 🆚 مقارنة مع Patterns تانية

| Pattern | الفرق |
|---------|-------|
| **Prototype** ✅ | ينشئ كائنات بنسخ كائن موجود |
| **Factory Method** | ينشئ كائنات عبر مصنع بدون تحديد الكلاس |
| **Builder** | يبني كائن معقد خطوة بخطوة من الصفر |
| **Singleton** | يضمن وجود instance واحد فقط |

---

## 🚀 كيفية التشغيل — How to Run

```bash
dart bin/creational/prototype_pattern/prototype_main.dart
```

**المخرجات المتوقعة:**
```
══════════════════════════════════════════════════
  PROTOTYPE PATTERN — نمط النموذج الأولي
══════════════════════════════════════════════════

══════════════════════════════════════════════════
  Example 1 — استنساخ مباشر / Direct Clone
══════════════════════════════════════════════════

🟦 Original character:
┌─────────────────────────────────────┐
│  Aric (Warrior)
│  ❤️  HP     : 200
│  ⚔️  Attack : 80
│  🛡️  Defense: 60
│  ✨ Skills : Shield Bash, War Cry
└─────────────────────────────────────┘

🟩 Cloned character (modified):
┌─────────────────────────────────────┐
│  Aric (Warrior)
│  ❤️  HP     : 150
│  ⚔️  Attack : 80
│  🛡️  Defense: 60
│  ✨ Skills : Shield Bash, War Cry, Whirlwind
└─────────────────────────────────────┘

🟦 Original (unchanged):
┌─────────────────────────────────────┐
│  Aric (Warrior)
│  ❤️  HP     : 200       ← لم يتغير ✅
│  ⚔️  Attack : 80
│  🛡️  Defense: 60
│  ✨ Skills : Shield Bash, War Cry  ← لم تتغير ✅
└─────────────────────────────────────┘
```

---

*Prototype Pattern — Creational Patterns Series* 🧬
