/// PART 1: الواجهة والكائنات — Prototype Interface & Concrete Classes
///
/// نمط Prototype يعتمد على:
/// 1. [Prototype] — الواجهة المجردة التي تُعرِّف عقد الاستنساخ
/// 2. [GameCharacter] — الكائن القابل للاستنساخ
///
/// Prototype pattern is based on:
/// 1. [Prototype] — Abstract interface defining the clone contract
/// 2. [GameCharacter] — The concrete cloneable object

// =============================================================================
// 1️⃣  الواجهة المجردة — Abstract Prototype Interface
// =============================================================================

/// العقد الذي يجب أن تنفذه كل الكائنات القابلة للنسخ.
/// Every cloneable object must implement this contract.
abstract class Prototype<T> {
  /// ينشئ نسخة مستقلة من الكائن.
  /// Creates an independent copy of the object.
  T clone();
}

// =============================================================================
// 2️⃣  الكائن القابل للنسخ — Concrete Prototype: GameCharacter
// =============================================================================

/// شخصية في لعبة فيديو — تمتلك إحصاءات قابلة للتخصيص.
/// A video-game character with customisable stats.
class GameCharacter implements Prototype<GameCharacter> {
  final String name;
  final String characterClass; // مثلاً: Warrior / Mage / Archer
  int health;
  int attackPower;
  int defense;
  List<String> skills; // قائمة مهارات — skills list

  GameCharacter({
    required this.name,
    required this.characterClass,
    required this.health,
    required this.attackPower,
    required this.defense,
    List<String>? skills,
  }) : skills = skills ?? [];

  // ---------------------------------------------------------------------------
  // ⭐ الطريقة الجوهرية — The Core Method: clone()
  // ---------------------------------------------------------------------------

  /// ينشئ نسخة طبق الأصل بشكل مستقل تماماً.
  ///
  /// ⚠️ مهم: نُنشئ قائمة `skills` جديدة (`List.from`)
  ///          لنضمن الـ Deep Copy — تغيير النسخة لا يؤثر على الأصل.
  ///
  /// Creates a completely independent copy.
  /// ⚠️ Important: we create a new `skills` list (`List.from`)
  ///               to guarantee a Deep Copy — changes to the clone
  ///               do NOT affect the original.
  @override
  GameCharacter clone() {
    return GameCharacter(
      name: name,
      characterClass: characterClass,
      health: health,
      attackPower: attackPower,
      defense: defense,
      skills: List.from(skills), // ← Deep Copy للقائمة!
    );
  }

  // ---------------------------------------------------------------------------
  // copyWith — تخصيص النسخة أثناء الاستنساخ
  // ---------------------------------------------------------------------------

  /// ينشئ نسخة معدَّلة — يمكن تغيير أي حقل بدون المساس بالأصل.
  /// Creates a modified copy — change any field without affecting the original.
  GameCharacter copyWith({
    String? name,
    String? characterClass,
    int? health,
    int? attackPower,
    int? defense,
    List<String>? skills,
  }) {
    return GameCharacter(
      name: name ?? this.name,
      characterClass: characterClass ?? this.characterClass,
      health: health ?? this.health,
      attackPower: attackPower ?? this.attackPower,
      defense: defense ?? this.defense,
      skills: skills ?? List.from(this.skills),
    );
  }

  // ---------------------------------------------------------------------------
  // describe — طباعة إحصاءات الشخصية
  // ---------------------------------------------------------------------------

  /// يطبع ملخصاً مقروءاً لإحصاءات الشخصية.
  /// Prints a human-readable summary of the character's stats.
  void describe() {
    print('┌─────────────────────────────────────┐');
    print('│  $name ($characterClass)');
    print('│  ❤️  HP     : $health');
    print('│  ⚔️  Attack : $attackPower');
    print('│  🛡️  Defense: $defense');
    print('│  ✨ Skills : ${skills.isEmpty ? "none" : skills.join(", ")}');
    print('└─────────────────────────────────────┘');
  }
}
