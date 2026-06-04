// ============================================================
// BASE INTERFACE (الواجهة الأساسية)
// ============================================================

/// English:
/// This is the PRODUCT interface. It defines the contract that all
/// concrete payment classes must follow.
/// The client code depends on this abstraction, not on concrete classes.
///
/// Arabic:
/// هذه هي واجهة المنتج (PRODUCT). تحدد العقد الذي يجب أن تتبعه جميع
/// فئات الدفع الفعلية. يعتمد كود العميل على هذا التجريد، وليس على الفئات الفعلية.
///
/// Factory Pattern Benefit / فائدة نمط المصنع:
/// The client doesn't need to know which specific class (CreditCard or PayPal)
/// is being created. It only knows about PaymentMethod interface.
///
/// العميل لا يحتاج لمعرفة أي فئة محددة (بطاقة ائتمان أو باي بال) يتم إنشاؤها.
/// فهو يعرف فقط واجهة PaymentMethod.
abstract class PaymentMethod {
  /// English: Common method that all payment types must implement
  /// Arabic: دالة مشتركة يجب أن تنفذها جميع أنواع الدفع
  void pay(double amount);
}

// ============================================================
// CONCRETE PRODUCT 1 (منتج فعلي 1)
// ============================================================

/// English:
/// CreditCardPayment is a CONCRETE PRODUCT.
/// It provides a specific implementation of the PaymentMethod interface.
///
/// Arabic:
/// CreditCardPayment هو منتج فعلي (CONCRETE PRODUCT).
/// يقدم تطبيقًا محددًا لواجهة PaymentMethod.
class CreditCardPayment implements PaymentMethod {
  @override
  void pay(double amount) {
    // English: Specific implementation for credit card payment
    // Arabic: تطبيق محدد للدفع ببطاقة الائتمان
    print('Paid $amount using Credit Card');
  }
}

// ============================================================
// CONCRETE PRODUCT 2 (منتج فعلي 2)
// ============================================================

/// English:
/// PayPalPayment is another CONCRETE PRODUCT.
/// It provides a DIFFERENT implementation of the same interface.
///
/// Arabic:
/// PayPalPayment هو منتج فعلي آخر (CONCRETE PRODUCT).
/// يقدم تطبيقًا مختلفًا لنفس الواجهة.
class PayPalPayment implements PaymentMethod {
  @override
  void pay(double amount) {
    // English: Specific implementation for PayPal payment
    // Arabic: تطبيق محدد للدفع عبر باي بال
    print('Paid $amount using PayPal');
  }
}

// ============================================================
// KEY INSIGHTS / أفكار رئيسية
// ============================================================

/// English:
/// 1. The interface (PaymentMethod) is the ABSTRACTION
/// 2. CreditCardPayment and PayPalPayment are IMPLEMENTATIONS
/// 3. Client code only knows about PaymentMethod (abstraction)
/// 4. This is called "Dependency Inversion" - depend on abstractions, not concretions
///
/// Arabic:
/// 1. الواجهة (PaymentMethod) هي التجريد (ABSTRACTION)
/// 2. CreditCardPayment و PayPalPayment هما التطبيقات (IMPLEMENTATIONS)
/// 3. كود العميل يعرف فقط عن PaymentMethod (التجريد)
/// 4. هذا يسمى "عكس الاعتماد" - اعتمد على التجريدات وليس على التفاصيل