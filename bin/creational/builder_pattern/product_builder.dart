// ============================================
// 📦 PART 1: PRODUCT - The Pizza we want to build
// الجزء الأول: المنتج - البيتزا التي نريد بنائها
// ============================================

/// 🍕 Pizza class - The final product
/// 🍕 كلاس البيتزا - المنتج النهائي
class Pizza {
  // ===== Required Fields - الحقول المطلوبة =====

  /// Size: 'small', 'medium', 'large'
  /// الحجم: 'صغير'، 'متوسط'، 'كبير'
  final String size;

  // ===== Optional Toppings - الإضافات الاختيارية =====
  // All default to false (كلها افتراضياً false)

  /// 🧀 Cheese topping - إضافة الجبن
  final bool cheese;

  /// 🍖 Pepperoni topping - إضافة الببروني
  final bool pepperoni;

  /// 🍄 Mushrooms topping - إضافة الفطر
  final bool mushrooms;

  /// 🫒 Olives topping - إضافة الزيتون
  final bool olives;

  /// 🧅 Onions topping - إضافة البصل
  final bool onions;

  // ===== Optional with default values - اختيارية بقيم افتراضية =====

  /// Crust type: 'thin', 'thick', 'stuffed'
  /// نوع العجين: 'رقيقة'، 'سميكة'، 'محشية'
  final String crustType;

  /// Extra cheese option - خيار الجبن الإضافي
  final bool extraCheese;

  // ===== Named Constructor - منشئ مسمّى =====
  //
  // 🔹 Intended to be called ONLY by PizzaBuilder.
  // 🔹 مخصص ليُستدعى فقط من PizzaBuilder.
  //
  // ⚠️ DART NOTE: In Dart, `_` means FILE-private (library-private),
  //    NOT class-private. So Pizza._() in product_builder.dart would
  //    be invisible to builder.dart (a different file/library).
  //    We use Pizza.create() instead — a named constructor that clearly
  //    signals "use the Builder, don't call this directly".
  //
  // ⚠️ ملاحظة دارت: في دارت، `_` تعني خاص للملف (library-private)
  //    وليس خاص للكلاس. لذلك Pizza._() في product_builder.dart
  //    مش مرئية من builder.dart. نستخدم Pizza.create() بدلاً منها.
  const Pizza.create({
    required this.size,
    this.cheese = false,
    this.pepperoni = false,
    this.mushrooms = false,
    this.olives = false,
    this.onions = false,
    this.crustType = 'thin',
    this.extraCheese = false,
  });

  // ===== Display Method - طريقة العرض =====

  /// Display pizza details in console
  /// عرض تفاصيل البيتزا في الكونسول
  void describe() {
    print('🍕 Pizza: $size size'); // الحجم
    print('   Crust: $crustType'); // نوع العجين

    print('   Toppings:'); // الإضافات
    if (cheese) print('   - Cheese 🧀');
    if (pepperoni) print('   - Pepperoni 🍖');
    if (mushrooms) print('   - Mushrooms 🍄');
    if (olives) print('   - Olives 🫒');
    if (onions) print('   - Onions 🧅');
    if (extraCheese) print('   - Extra Cheese 🧀✨');
    print('   ---');
  }
}