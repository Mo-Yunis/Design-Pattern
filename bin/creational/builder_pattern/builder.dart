// ============================================
// 🔧 PART 2: BUILDER - Builds Pizza step by step
// الجزء الثاني: البناء - يبني البيتزا خطوة بخطوة
// ============================================

import 'product_builder.dart';

/// 🏗️ Pizza Builder - Constructs Pizza objects
/// 🏗️ بناء البيتزا - يقوم بإنشاء كائنات البيتزا
class PizzaBuilder {
  // ===== Private Fields - الحقول الخاصة =====

  /// Size with default 'medium'
  /// الحجم بالقيمة الافتراضية 'medium'
  String _size = 'medium';

  /// All toppings default to false
  /// جميع الإضافات افتراضياً false
  bool _cheese = false;
  bool _pepperoni = false;
  bool _mushrooms = false;
  bool _olives = false;
  bool _onions = false;

  /// Crust with default 'thin'
  /// نوع العجين بالقيمة الافتراضية 'thin'
  String _crustType = 'thin';

  /// Extra cheese default false
  /// الجبن الإضافي افتراضياً false
  bool _extraCheese = false;

  // ===== Setter Methods - طرق التعيين =====
  // 🔑 Each method returns 'this' for method chaining
  // 🔑 كل طريقة ترجع 'this' للتسلسل

  /// Set pizza size (small, medium, large)
  /// تعيين حجم البيتزا (صغير، متوسط، كبير)
  PizzaBuilder setSize(String size) {
    _size = size;
    return this; // 🔑 Returns itself for chaining
  }

  /// Add cheese topping
  /// إضافة الجبن
  PizzaBuilder addCheese() {
    _cheese = true;
    return this;
  }

  /// Add pepperoni topping
  /// إضافة الببروني
  PizzaBuilder addPepperoni() {
    _pepperoni = true;
    return this;
  }

  /// Add mushrooms topping
  /// إضافة الفطر
  PizzaBuilder addMushrooms() {
    _mushrooms = true;
    return this;
  }

  /// Add olives topping
  /// إضافة الزيتون
  PizzaBuilder addOlives() {
    _olives = true;
    return this;
  }

  /// Add onions topping
  /// إضافة البصل
  PizzaBuilder addOnions() {
    _onions = true;
    return this;
  }

  /// Set crust type (thin, thick, stuffed)
  /// تعيين نوع العجين (رقيقة، سميكة، محشية)
  PizzaBuilder setCrustType(String crustType) {
    _crustType = crustType;
    return this;
  }

  /// Add extra cheese
  /// إضافة جبن إضافي
  PizzaBuilder addExtraCheese() {
    _extraCheese = true;
    return this;
  }

  // ===== Build Method - طريقة البناء =====

  /// 🔨 Build and return the final Pizza object
  /// 🔨 بناء وإرجاع كائن البيتزا النهائي

  /// Validates required fields before building
  /// يتحقق من الحقول المطلوبة قبل البناء
  Pizza build() {
    // ✅ Validation: Size is required
    // ✅ التحقق: الحجم مطلوب
    if (_size.isEmpty) {
      throw Exception('❌ Pizza must have a size!');
      // استثناء: البيتزا يجب أن يكون لها حجم!
    }

    // ✅ Validation: Size must be valid
    // ✅ التحقق: الحجم يجب أن يكون صحيحاً
    if (!['small', 'medium', 'large'].contains(_size)) {
      throw Exception('❌ Invalid size! Use: small, medium, large');
      // استثناء: حجم غير صحيح! استخدم: صغير، متوسط، كبير
    }

    // 🔹 Create and return Pizza using Pizza.create() named constructor
    // 🔹 إنشاء وإرجاع بيتزا باستخدام المنشئ المسمّى Pizza.create()
    //
    // ⭐ Why Pizza.create() and not Pizza._() ?
    //    In Dart, `_` is FILE-private. Pizza._() lives in product_builder.dart
    //    so it's invisible here in builder.dart (a separate library).
    //    Pizza.create() is our convention: "only Builder should call this".
    //
    // ⭐ لماذا Pizza.create() وليس Pizza._() ؟
    //    في دارت `_` خاص للملف. Pizza._() موجود في product_builder.dart
    //    فمش مرئي هنا في builder.dart (مكتبة منفصلة).
    //    Pizza.create() هو اتفاقيتنا: "فقط Builder يستدعي هذا".
    return Pizza.create(
      size: _size,
      cheese: _cheese,
      pepperoni: _pepperoni,
      mushrooms: _mushrooms,
      olives: _olives,
      onions: _onions,
      crustType: _crustType,
      extraCheese: _extraCheese,
    );
  }
}