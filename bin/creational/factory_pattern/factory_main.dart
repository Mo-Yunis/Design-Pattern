// ============================================================
// CLIENT CODE (كود العميل)
// ============================================================

import 'base_interface.dart';
import 'factory_class.dart';

/// English:
/// MAIN FUNCTION - Simulates client code (could be a Flutter Widget)
/// The client wants to process a payment but doesn't know/care
/// about which payment class is actually created.
///
/// Arabic:
/// الدالة الرئيسية - تحاكي كود العميل (يمكن أن تكون ويدجت Flutter)
/// العميل يريد معالجة الدفع لكنه لا يعرف/يهتم بأي فئة دفع
/// سيتم إنشاؤها فعليًا.
void main() {
  // ==========================================================
  // STEP 1: Ask the factory to create a payment object
  // الخطوة 1: اطلب من المصنع إنشاء كائن دفع
  // ==========================================================

  /// English:
  /// The client calls the factory with a parameter 'credit'
  /// The factory decides: "I need to create a CreditCardPayment"
  /// The client receives a PaymentMethod interface reference
  ///
  /// The client does NOT know that it got a CreditCardPayment!
  /// It only knows it's a PaymentMethod.
  /// This is called PROGRAMMING TO AN INTERFACE, NOT AN IMPLEMENTATION
  ///
  /// Arabic:
  /// العميل يستدعي المصنع مع باراميتر 'credit'
  /// المصنع يقرر: "أحتاج لإنشاء CreditCardPayment"
  /// العميل يستقبل مرجع لواجهة PaymentMethod
  ///
  /// العميل لا يعلم أنه حصل على CreditCardPayment!
  ///他只 يعرف أنها PaymentMethod.
  /// هذا يسمى البرمجة نحو الواجهة، وليس نحو التنفيذ
  PaymentMethod payment = PaymentFactory.create('credit');

  // ==========================================================
  // STEP 2: Use the created object (without knowing its type)
  // الخطوة 2: استخدم الكائن الذي تم إنشاؤه (بدون معرفة نوعه)
  // ==========================================================

  /// English:
  /// The client calls the pay() method.
  /// At runtime, Dart knows that 'payment' is actually a
  /// CreditCardPayment object, so CreditCardPayment.pay() runs.
  /// This is called POLYMORPHISM - the same method name behaves
  /// differently based on the actual object type.
  ///
  /// Arabic:
  /// العميل يستدعي الدالة pay().
  /// أثناء التشغيل، Dart يعلم أن 'payment' هو في الواقع
  /// كائن CreditCardPayment، لذلك يتم تشغيل CreditCardPayment.pay().
  /// هذا يسمى تعدد الأشكال (POLYMORPHISM) - نفس اسم الدالة
  /// يتصرف بشكل مختلف بناءً على نوع الكائن الفعلي.
  payment.pay(100.0);

  // ==========================================================
  // EXAMPLE WITH DIFFERENT TYPE / مثال بنوع مختلف
  // ==========================================================

  /// English:
  /// Now let's create a PayPal payment
  /// The SAME factory method, SAME interface, DIFFERENT behavior
  ///
  /// Arabic:
  /// الآن لنقم بإنشاء دفع باي بال
  /// نفس دالة المصنع، نفس الواجهة، سلوك مختلف
  PaymentMethod anotherPayment = PaymentFactory.create('paypal');
  anotherPayment.pay(50.0);

}
