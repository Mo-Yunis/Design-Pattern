// ============================================================
// FACTORY CLASS (فئة المصنع)
// ============================================================

import 'base_interface.dart';

/// English:
/// ============================================================
/// FACTORY PATTERN - CREATIONAL DESIGN PATTERN
/// ============================================================
///
/// What is Factory Pattern?
/// It's a design pattern that provides a way to create objects
/// WITHOUT specifying the exact class of object that will be created.
///
/// Why use it?
/// 1. ENCAPSULATION: Creation logic is hidden inside the factory
/// 2. DECOUPLING: Client code doesn't depend on concrete classes
/// 3. MAINTAINABILITY: Adding new payment types only requires changing ONE place
/// 4. SINGLE RESPONSIBILITY: Factory ONLY handles object creation
///
/// Arabic:
/// ============================================================
/// نمط المصنع - نمط تصميم إبداعي
/// ============================================================
///
/// ما هو نمط المصنع؟
/// هو نمط تصميم يوفر طريقة لإنشاء الكائنات WITHOUT تحديد الفئة
/// الدقيقة للكائن الذي سيتم إنشاؤه.
///
/// لماذا نستخدمه؟
/// 1. التغليف: منطق الإنشاء مخفي داخل المصنع
/// 2. الفصل: كود العميل لا يعتمد على الفئات الفعلية
/// 3. قابلية الصيانة: إضافة أنواع دفع جديدة يتطلب تغيير مكان واحد فقط
/// 4. مسؤولية واحدة: المصنع يتعامل فقط مع إنشاء الكائنات
/// ============================================================
class PaymentFactory {
  // English:
  // This is a STATIC FACTORY METHOD (not a constructor)
  // It's responsible for creating and returning the appropriate
  // PaymentMethod object based on the input parameter.
  //
  // The word "static" means we can call it without creating
  // an instance of PaymentFactory: PaymentFactory.create('credit')
  //
  // Arabic:
  // هذه دالة مصنع STATIC (ليست منشئ)
  // وهي مسؤولة عن إنشاء وإرجاع كائن PaymentMethod المناسب
  // بناءً على معامل الإدخال.
  //
  // كلمة "static" تعني أنه يمكننا استدعاؤها دون إنشاء
  // نسخة من PaymentFactory: PaymentFactory.create('credit')
  static PaymentMethod create(String type) {
    // English:
    // The factory DECIDES which concrete class to instantiate.
    // This decision is based on the 'type' parameter.
    // This is the "business logic" of object creation.
    //
    // Arabic:
    // المصنع يقرر أي فئة فعلية سيتم إنشاؤها.
    // هذا القرار مبني على معامل 'type'.
    // هذا هو "منطق الأعمال" لإنشاء الكائن.
    switch (type.toLowerCase()) {
      case 'credit':
      // English: Create and return CreditCardPayment object
      // Arabic: إنشاء وإرجاع كائن CreditCardPayment
        return CreditCardPayment();

      case 'paypal':
      // English: Create and return PayPalPayment object
      // Arabic: إنشاء وإرجاع كائن PayPalPayment
        return PayPalPayment();

      default:
      // English: Handle invalid input by throwing an exception
      // Arabic: التعامل مع الإدخال غير الصالح عن طريق رمي استثناء
        throw Exception('Unknown payment type: $type');
    }
  }
}

// ============================================================
// ADVANTAGES OF THIS APPROACH / مزايا هذا الأسلوب
// ============================================================

/// English:
/// ADVANTAGES:
/// 1. To add a new payment method (e.g., CryptoPayment):
///    - Create new class implementing PaymentMethod
///    - Add ONE new 'case' in the switch statement
///    - NO changes needed in client code!
///
/// 2. The factory can cache/reuse objects if creation is expensive
///
/// 3. The factory can return existing objects (Singleton pattern)
///
/// Arabic:
/// المزايا:
/// 1. لإضافة طريقة دفع جديدة (مثل الدفع بالعملات الرقمية):
///    - إنشاء فئة جديدة تطبق PaymentMethod
///    - إضافة حالة 'case' واحدة جديدة في switch
///    - لا حاجة لتغييرات في كود العميل!
///
/// 2. يمكن للمصنع تخزين/إعادة استخدام الكائنات إذا كان الإنشاء مكلفًا
///
/// 3. يمكن للمصنع إرجاع كائنات موجودة (نمط Singleton)
/// ============================================================

/// English:
/// ALTERNATIVE APPROACH (not used here):
/// Instead of a separate Factory class, you can put the factory
/// method directly on the abstract class:
///
/// abstract class PaymentMethod {
///   factory PaymentMethod.create(String type) {
///     // logic here
///   }
///   void pay(double amount);
/// }
///
/// Arabic:
/// أسلوب بديل (غير مستخدم هنا):
/// بدلاً من فئة مصنع منفصلة، يمكنك وضع دالة المصنع
/// مباشرة على الواجهة المجردة:
///
/// abstract class PaymentMethod {
///   factory PaymentMethod.create(String type) {
///     // المنطق هنا
///   }
///   void pay(double amount);
/// }
/// ============================================================