/// PART 2: مسجل النماذج الأولية — Prototype Registry
///
/// الـ Registry هو مستودع مركزي يحفظ نماذج جاهزة مسبقاً،
/// ويوفر `get()` و `register()` بدلاً من إنشاء كائنات من الصفر.
///
/// The Registry is a central store of pre-built prototypes.
/// It provides `get()` and `register()` instead of creating
/// objects from scratch every time.

import 'prototype_interface.dart';

// =============================================================================
// 🗄️ الـ Registry — Prototype Registry
// =============================================================================

/// مستودع النماذج الأولية — يحفظ نسخاً جاهزة لأنواع مختلفة من الكائنات.
/// Prototype registry — stores pre-configured instances of various types.
class CharacterRegistry {
  // خريطة بين اسم النموذج والنموذج نفسه
  // Map between prototype name and the prototype itself
  final Map<String, GameCharacter> _prototypes = {};

  // ---------------------------------------------------------------------------
  // register — يضيف نموذجاً جديداً للمسجل
  // ---------------------------------------------------------------------------

  /// يضيف نموذجاً أولياً للمسجل بمفتاح محدد.
  /// Adds a prototype to the registry under a given key.
  void register(String key, GameCharacter character) {
    _prototypes[key] = character;
    print('✅ Registered prototype: "$key"');
  }

  // ---------------------------------------------------------------------------
  // get — يسترجع نسخة جديدة من النموذج
  // ---------------------------------------------------------------------------

  /// يُعيد **نسخة مستنسخة** من النموذج المخزَّن.
  /// Returns a **cloned copy** of the stored prototype.
  /// ⚠️ دائماً يُرجع clone وليس المرجع الأصلي!
  /// ⚠️ Always returns a clone, never the original reference!
  GameCharacter get(String key) {
    final prototype = _prototypes[key];
    if (prototype == null) {
      throw ArgumentError('No prototype registered under key: "$key"');
    }
    return prototype.clone(); // ← نسخة مستقلة ✅
  }

  // ---------------------------------------------------------------------------
  // listKeys — يُظهر النماذج المتاحة
  // ---------------------------------------------------------------------------

  /// يطبع جميع المفاتيح المسجّلة في المسجل.
  /// Prints all registered keys in the registry.
  void listKeys() {
    print('\n📋 Available prototypes: ${_prototypes.keys.join(", ")}');
  }
}
