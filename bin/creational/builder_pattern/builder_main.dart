// ============================================
// 🚀 PART 4: USAGE - How to use the Builder
// الجزء الرابع: الاستخدام - كيفية استخدام البناء
// ============================================

import 'builder.dart';
import 'director.dart';

void main() {
  print('=' * 50);
  print('🏗️ BUILDER PATTERN - PIZZA EXAMPLE 🍕');
  print('🏗️ نمط البناء - مثال البيتزا 🍕');
  print('=' * 50);

  // ==========================================
  // EXAMPLE 1: Manual Building (Method Chaining)
  // المثال 1: بناء يدوي (تسلسل الطرق)
  // ==========================================

  print('\n📝 EXAMPLE 1: Manual Building');
  print('📝 المثال 1: بناء يدوي');
  print('-' * 40);

  /// 🔑 DART CHAINING RULE:
  ///    Each setter (setSize, addCheese...) returns `this` (PizzaBuilder).
  ///    So we chain them with DOT (.) — not cascade (..)
  ///    and end with .build() which returns Pizza. ✅
  ///
  /// 🔑 قاعدة التسلسل في دارت:
  ///    كل setter يرجع `this` (PizzaBuilder)
  ///    فنسلسلها بنقطة (.) وليس (..)
  ///    وتنتهي بـ .build() اللي ترجع Pizza ✅
  ///
  /// ❌ WRONG — cascade (..) makes Dart infer type as PizzaBuilder:
  ///    final pizza = PizzaBuilder()..setSize('large')..addCheese()..build();
  ///    //  pizza is PizzaBuilder here, NOT Pizza! describe() won't work.
  ///
  /// ✅ CORRECT — use dot chaining (.):
  final pizza1 = PizzaBuilder()
      .setSize('large')       // returns PizzaBuilder
      .addCheese()            // returns PizzaBuilder
      .addPepperoni()         // returns PizzaBuilder
      .addMushrooms()         // returns PizzaBuilder
      .setCrustType('thin')   // returns PizzaBuilder
      .build();               // returns Pizza ✅

  pizza1.describe();


  // ==========================================
  // EXAMPLE 2: Using Director (Pre-made recipes)
  // المثال 2: استخدام المخرج (وصفات جاهزة)
  // ==========================================

  print('\n📝 EXAMPLE 2: Using Director');
  print('📝 المثال 2: استخدام المخرج');
  print('-' * 40);

  /// Create builder and director
  /// إنشاء بناء ومخرج
  final builder = PizzaBuilder();
  final director = PizzaDirector(builder);

  // Recipe 1: Vegetarian
  // وصفة 1: نباتية
  print('\n🌱 Vegetarian Pizza / بيتزا نباتية:');
  final vegPizza = director.makeVegetarianPizza();
  vegPizza.describe();

  // Recipe 2: Meat Lovers
  // وصفة 2: عشاق اللحم
  print('\n🍖 Meat Lovers Pizza / بيتزا عشاق اللحم:');
  final meatPizza = director.makeMeatLoversPizza();
  meatPizza.describe();

  // Recipe 3: Simple Cheese
  // وصفة 3: جبن بسيطة
  print('\n🧀 Simple Cheese Pizza / بيتزا جبن بسيطة:');
  final cheesePizza = director.makeSimpleCheesePizza();
  cheesePizza.describe();


  // ==========================================
  // EXAMPLE 3: Custom with Director
  // المثال 3: مخصص باستخدام المخرج
  // ==========================================

  print('\n📝 EXAMPLE 3: Custom Pizza with Director');
  print('📝 المثال 3: بيتزا مخصصة مع المخرج');
  print('-' * 40);

  /// Using director's custom method
  /// استخدام الطريقة المخصصة في المخرج
  final customPizza = director.makeCustomPizza(
    size: 'medium',
    withCheese: true,
    withPepperoni: true,
    withOlives: true,
    extraCheese: true,
    crust: 'thick',
  );
  customPizza.describe();


  // ==========================================
  // EXAMPLE 4: Full Method Chaining
  // المثال 4: التسلسل الكامل بالطرق
  // ==========================================

  print('\n📝 EXAMPLE 4: Full Method Chaining');
  print('📝 المثال 4: التسلسل الكامل');
  print('-' * 40);

  /// ✅ Correct pattern: chain all methods with (.) dot
  /// Each setter returns PizzaBuilder → chain continues
  /// build() returns Pizza → chain ends with correct type
  ///
  /// ✅ النمط الصحيح: سلسل كل الطرق بنقطة (.)
  /// كل setter يرجع PizzaBuilder ← يكمل التسلسل
  /// build() يرجع Pizza ← ينتهي التسلسل بالنوع الصحيح
  final chainPizza = PizzaBuilder()
      .setSize('medium')
      .addCheese()
      .addPepperoni()
      .addOlives()
      .addExtraCheese()
      .setCrustType('thick')
      .build();   // ✅ Pizza — not PizzaBuilder

  chainPizza.describe();


  // ==========================================
  // EXAMPLE 5: Validation Test
  // المثال 5: اختبار التحقق
  // ==========================================

  print('\n📝 EXAMPLE 5: Validation Test');
  print('📝 المثال 5: اختبار التحقق');
  print('-' * 40);

  print('⚠️ Testing invalid size / اختبار حجم غير صحيح:');
  try {
    /// ❌ 'huge' is not in ['small', 'medium', 'large']
    /// ❌ 'huge' ليست ضمن ['small', 'medium', 'large']
    /// build() will throw before creating the Pizza
    /// build() ستُطلق استثناء قبل إنشاء البيتزا
    PizzaBuilder()
        .setSize('huge')  // ❌ Invalid size / حجم غير صحيح
        .addCheese()
        .build();         // 💥 throws Exception
  } catch (e) {
    print('❌ Error caught / تم اكتشاف خطأ:');
    print('   $e');
  }

  print('\n⚠️ Testing empty size / اختبار حجم فارغ:');
  try {
    /// ❌ Empty string fails the isEmpty check in build()
    /// ❌ النص الفارغ يفشل في تحقق isEmpty داخل build()
    PizzaBuilder()
        .setSize('')    // ❌ Empty size / حجم فارغ
        .addCheese()
        .build();       // 💥 throws Exception
  } catch (e) {
    print('❌ Error caught / تم اكتشاف خطأ:');
    print('   $e');
  }


  // ==========================================
  // EXAMPLE 6: Reusing Builder
  // المثال 6: إعادة استخدام البناء
  // ==========================================

  print('\n📝 EXAMPLE 6: Reusing Builder');
  print('📝 المثال 6: إعادة استخدام البناء');
  print('-' * 40);

  /// You can reuse the same builder for multiple pizzas
  /// يمكنك إعادة استخدام نفس البناء لبيتزا متعددة

  final reusableBuilder = PizzaBuilder();

  // First pizza: Small cheese
  // بيتزا أولى: جبن صغيرة
  print('\n🧀 First pizza: Small cheese');
  final pizzaA = reusableBuilder
      .setSize('small')
      .addCheese()
      .build();  // ✅ returns Pizza
  pizzaA.describe();

  // Second pizza: Large meat lovers (reusing same builder)
  // بيتزا ثانية: عشاق اللحم كبيرة (نفس البناء)
  //
  // ⚠️ KNOWN GOTCHA: Builder fields ACCUMULATE between builds!
  //    The builder was NOT reset after pizzaA.
  //    pizzaB already has cheese=true from pizzaA's build.
  //    It will inherit ALL previously set fields.
  //
  // ⚠️ تنبيه مهم: حقول البناء تتراكم بين عمليات البناء!
  //    البناء لم يُعاد تهيئته بعد pizzaA.
  //    pizzaB لديها cheese=true من بناء pizzaA بالفعل.
  //
  // ✅ To avoid this: create a NEW PizzaBuilder() each time.
  // ✅ لتجنب هذا: أنشئ PizzaBuilder() جديداً في كل مرة.
  print('\n🍖 Second pizza: Large meat lovers (note accumulated state!)');
  final pizzaB = reusableBuilder
      .setSize('large')
      .addCheese()
      .addPepperoni()
      .addExtraCheese()
      .build();  // ✅ returns Pizza (but may carry previous state)
  pizzaB.describe();



}