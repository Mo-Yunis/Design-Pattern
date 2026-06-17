// ============================================
// 🎯 PART 3: DIRECTOR - Pre-made pizza recipes
// الجزء الثالث: المخرج - وصفات بيتزا جاهزة
// ============================================

import 'builder.dart';
import 'product_builder.dart';

/// 🎬 Pizza Director - Provides ready-made recipes
/// 🎬 مخرج البيتزا - يقدم وصفات جاهزة
///
/// The Director knows HOW to build specific pizzas.
/// It uses the Builder's step-by-step methods to assemble a recipe.
/// This separates the "what to build" (Director) from "how to build" (Builder).
///
/// المخرج يعرف كيف يبني بيتزا معينة.
/// يستخدم طرق البناء خطوة بخطوة لتجميع وصفة.
/// هذا يفصل "ماذا نبني" (المخرج) عن "كيف نبني" (البناء).
class PizzaDirector {
  /// The builder to use for construction
  /// البناء المستخدم للبناء
  final PizzaBuilder builder;

  /// Constructor receives a builder
  /// المنشئ يستقبل البناء
  PizzaDirector(this.builder);

  // ===== Recipe 1: Vegetarian Pizza - وصفة البيتزا النباتية =====

  /// 🌱 Create a vegetarian pizza with mushrooms, olives, onions
  /// 🌱 إنشاء بيتزا نباتية مع فطر، زيتون، بصل
  ///
  /// 🔑 DART CHAINING: Since each setter returns `this` (PizzaBuilder),
  ///    we can chain with dot (.) all the way through to .build()
  ///    which returns Pizza — the correct final type. ✅
  ///
  /// 🔑 تسلسل دارت: بما أن كل setter يرجع `this` (PizzaBuilder)،
  ///    نسلسل بنقطة (.) حتى .build() الذي يرجع Pizza — النوع الصحيح. ✅
  ///
  /// ❌ AVOID: builder..setSize()..build()
  ///    Cascade (..) makes the whole expression type PizzaBuilder, not Pizza.
  ///
  /// ❌ تجنب: builder..setSize()..build()
  ///    الـ cascade (..) يجعل نوع التعبير كله PizzaBuilder وليس Pizza.
  Pizza makeVegetarianPizza() {
    return builder
        .setSize('medium')      // حجم متوسط — returns PizzaBuilder
        .addCheese()            // إضافة جبن — returns PizzaBuilder
        .addMushrooms()         // إضافة فطر — returns PizzaBuilder
        .addOlives()            // إضافة زيتون — returns PizzaBuilder
        .addOnions()            // إضافة بصل — returns PizzaBuilder
        .setCrustType('thick')  // عجين سميك — returns PizzaBuilder
        .build();               // بناء البيتزا — returns Pizza ✅
  }

  // ===== Recipe 2: Meat Lovers Pizza - وصفة بيتزا عشاق اللحم =====

  /// 🍖 Create a meat lovers pizza with pepperoni and extra cheese
  /// 🍖 إنشاء بيتزا عشاق اللحم مع ببروني وجبن إضافي
  Pizza makeMeatLoversPizza() {
    return builder
        .setSize('large')         // حجم كبير
        .addCheese()              // إضافة جبن
        .addPepperoni()           // إضافة ببروني
        .addExtraCheese()         // إضافة جبن إضافي
        .setCrustType('stuffed')  // عجين محشي
        .build();                 // بناء البيتزا ✅
  }

  // ===== Recipe 3: Simple Cheese Pizza - وصفة بيتزا الجبن البسيطة =====

  /// 🧀 Create a simple cheese pizza
  /// 🧀 إنشاء بيتزا جبن بسيطة
  Pizza makeSimpleCheesePizza() {
    return builder
        .setSize('small')   // حجم صغير
        .addCheese()        // إضافة جبن
        .build();           // بناء البيتزا ✅
  }

  // ===== Recipe 4: Custom with validation - وصفة مخصصة مع تحقق =====

  /// 🌟 Create a custom pizza with validation
  /// 🌟 إنشاء بيتزا مخصصة مع تحقق
  ///
  /// Uses named parameters with defaults for maximum flexibility.
  /// يستخدم معاملات مسماة بقيم افتراضية لأقصى قدر من المرونة.
  Pizza makeCustomPizza({
    required String size,
    bool withCheese = true,
    bool withPepperoni = false,
    bool withMushrooms = false,
    bool withOlives = false,
    bool withOnions = false,
    String crust = 'thin',
    bool extraCheese = false,
  }) {
    // Set size first — تعيين الحجم أولاً
    builder.setSize(size);

    // Conditionally add toppings — إضافة الإضافات حسب المعاملات
    if (withCheese) builder.addCheese();
    if (withPepperoni) builder.addPepperoni();
    if (withMushrooms) builder.addMushrooms();
    if (withOlives) builder.addOlives();
    if (withOnions) builder.addOnions();
    if (extraCheese) builder.addExtraCheese();

    // Set crust — تعيين نوع العجين
    builder.setCrustType(crust);

    // Build and return — بناء وإرجاع
    return builder.build(); // ✅ returns Pizza
  }
}