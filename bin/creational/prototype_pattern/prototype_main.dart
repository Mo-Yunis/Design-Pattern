/// PART 4: الاستخدام — Client Code
///
/// ٥ أمثلة عملية تغطي جميع سيناريوهات نمط Prototype:
///
/// Example 1 → استنساخ مباشر       (Direct clone)
/// Example 2 → استنساخ مع تعديل   (Clone + copyWith)
/// Example 3 → استخدام الـ Registry (Registry)
/// Example 4 → إثبات الاستقلالية   (Deep Copy proof)
/// Example 5 → مقارنة الأداء        (Performance comparison)

import 'prototype_interface.dart';
import 'prototype_registry.dart';

void main() {
  _separator('PROTOTYPE PATTERN — نمط النموذج الأولي');

  _example1DirectClone();
  _example2CopyWith();
  _example3Registry();
  _example4DeepCopyProof();
  _example5PerformanceComparison();
}

// =============================================================================
// Example 1 — استنساخ مباشر (Direct Clone)
// =============================================================================

/// يُظهر كيف يُنشئ clone() نسخة مستقلة بدون تأثير على الأصل.
/// Shows how clone() creates an independent copy without affecting the original.
void _example1DirectClone() {
  _separator('Example 1 — استنساخ مباشر / Direct Clone');

  // النموذج الأصلي — the original prototype
  final warrior = GameCharacter(
    name: 'Aric',
    characterClass: 'Warrior',
    health: 200,
    attackPower: 80,
    defense: 60,
    skills: ['Shield Bash', 'War Cry'],
  );

  print('🟦 Original character:');
  warrior.describe();

  // الاستنساخ — cloning
  final warriorClone = warrior.clone();
  warriorClone.health = 150; // تعديل النسخة فقط — modifying clone only
  warriorClone.skills.add('Whirlwind'); // إضافة مهارة للنسخة

  print('\n🟩 Cloned character (modified):');
  warriorClone.describe();

  print('\n🟦 Original (unchanged):');
  warrior.describe();
  // الأصل لم يتغير ✅
}

// =============================================================================
// Example 2 — استنساخ مع تعديل (copyWith)
// =============================================================================

/// يُظهر استخدام copyWith لإنشاء نسخة مخصصة من النموذج الأولي.
/// Shows copyWith for creating a customized variant of the prototype.
void _example2CopyWith() {
  _separator('Example 2 — استنساخ مع تعديل / Clone + copyWith');

  final mage = GameCharacter(
    name: 'Lyra',
    characterClass: 'Mage',
    health: 120,
    attackPower: 150,
    defense: 30,
    skills: ['Fireball', 'Ice Lance'],
  );

  print('🔵 Base Mage:');
  mage.describe();

  // نسخة مطورة — upgraded variant
  final archmage = mage.copyWith(
    name: 'Lyra the Archmage',
    health: 180,
    attackPower: 220,
    skills: ['Fireball', 'Ice Lance', 'Thunder Storm', 'Meteor'],
  );

  print('\n🟣 Archmage variant (via copyWith):');
  archmage.describe();
}

// =============================================================================
// Example 3 — استخدام الـ Registry (Registry)
// =============================================================================

/// يُظهر كيف يعمل الـ Registry كمستودع مركزي للنماذج الجاهزة.
/// Shows how the Registry acts as a central store for pre-built prototypes.
void _example3Registry() {
  _separator('Example 3 — استخدام الـ Registry / Using the Registry');

  final registry = CharacterRegistry();

  // تسجيل النماذج الأولية — register the base prototypes
  registry.register(
    'warrior',
    GameCharacter(
      name: 'Default Warrior',
      characterClass: 'Warrior',
      health: 200,
      attackPower: 80,
      defense: 60,
      skills: ['Shield Bash'],
    ),
  );

  registry.register(
    'archer',
    GameCharacter(
      name: 'Default Archer',
      characterClass: 'Archer',
      health: 140,
      attackPower: 110,
      defense: 40,
      skills: ['Arrow Shot', 'Eagle Eye'],
    ),
  );

  registry.listKeys();

  // الاسترجاع — always returns a fresh clone!
  print('\n⚔️  Spawning 2 warriors from registry:');
  final player1 = registry.get('warrior');
  player1.skills.add('Berserker Rage'); // تخصيص اللاعب الأول

  final player2 = registry.get('warrior');
  // player2 نظيف تماماً — player2 is completely fresh

  player1.describe();
  player2.describe();
}

// =============================================================================
// Example 4 — إثبات الـ Deep Copy (Deep Copy Proof)
// =============================================================================

/// يُثبت أن قائمة المهارات (List) مستنسخة بعمق وليست مشتركة.
/// Proves that the skills list is deeply copied, not shared.
void _example4DeepCopyProof() {
  _separator('Example 4 — إثبات الـ Deep Copy / Deep Copy Proof');

  final original = GameCharacter(
    name: 'Original',
    characterClass: 'Rogue',
    health: 160,
    attackPower: 100,
    defense: 45,
    skills: ['Backstab'],
  );

  final cloned = original.clone();

  // نعدّل قائمة النسخة — modify the clone's list
  cloned.skills.add('Poison Dagger');
  cloned.health = 999;

  print('📦 Original skills: ${original.skills}');
  print('📦 Cloned skills  : ${cloned.skills}');
  print('❤️  Original health: ${original.health}');
  print('❤️  Cloned health  : ${cloned.health}');

  final skillsIsolated = !original.skills.contains('Poison Dagger');
  final healthIsolated = original.health != 999;

  print('\n${skillsIsolated ? "✅" : "❌"} Skills are independent (Deep Copy)');
  print('${healthIsolated ? "✅" : "❌"} Health is independent');
}

// =============================================================================
// Example 5 — مقارنة الأداء (Performance)
// =============================================================================

/// يُقارن زمن إنشاء 1000 كائن جديد vs استنساخ 1000 كائن.
/// Compares time to create 1000 new objects vs cloning 1000 objects.
void _example5PerformanceComparison() {
  _separator('Example 5 — مقارنة الأداء / Performance Comparison');

  const count = 1000;

  // ─── إنشاء من الصفر ───
  final sw1 = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    GameCharacter(
      name: 'Hero $i',
      characterClass: 'Warrior',
      health: 200,
      attackPower: 80,
      defense: 60,
      skills: ['Skill A', 'Skill B', 'Skill C'],
    );
  }
  sw1.stop();

  // ─── استنساخ ───
  final prototype = GameCharacter(
    name: 'Hero',
    characterClass: 'Warrior',
    health: 200,
    attackPower: 80,
    defense: 60,
    skills: ['Skill A', 'Skill B', 'Skill C'],
  );

  final sw2 = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    prototype.clone();
  }
  sw2.stop();

  print('Creating $count objects from scratch : ${sw1.elapsedMicroseconds}µs');
  print('Cloning  $count objects from prototype: ${sw2.elapsedMicroseconds}µs');
  print('\n✅ Clone is typically faster for complex objects');
  print('   (no repeated constructor logic or validation)');
}

// =============================================================================
// Helper
// =============================================================================

void _separator(String title) {
  print('\n${'═' * 50}');
  print('  $title');
  print('${'═' * 50}\n');
}
