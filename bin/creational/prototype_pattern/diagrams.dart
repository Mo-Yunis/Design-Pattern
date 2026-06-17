/// PART 3: مخططات العلاقات — ASCII Diagrams
///
/// هذا الملف لا يُنفَّذ — فقط للتوثيق البصري.
/// This file is NOT executed — it is for visual documentation only.
///
/// ==========================================================================
///
///  CLASS DIAGRAM — مخطط الكلاسات
///  ─────────────────────────────────────────────────────────────────────────
///
///  ┌──────────────────────┐
///  │   «interface»        │
///  │   Prototype<T>       │  ← Abstract contract
///  ├──────────────────────┤
///  │ + clone() → T        │
///  └──────────┬───────────┘
///             │ implements
///             ▼
///  ┌──────────────────────────────┐
///  │       GameCharacter          │  ← Concrete Prototype
///  ├──────────────────────────────┤
///  │ - name          : String     │
///  │ - characterClass: String     │
///  │ - health        : int        │
///  │ - attackPower   : int        │
///  │ - defense       : int        │
///  │ - skills        : List       │
///  ├──────────────────────────────┤
///  │ + clone()    → GameCharacter │  ← Deep copy
///  │ + copyWith() → GameCharacter │  ← Modified clone
///  │ + describe()                 │
///  └──────────────────────────────┘
///             ▲
///             │ stores & clones
///  ┌──────────┴───────────────────┐
///  │      CharacterRegistry       │  ← Registry (optional)
///  ├──────────────────────────────┤
///  │ - _prototypes: Map<String,…> │
///  ├──────────────────────────────┤
///  │ + register(key, character)   │
///  │ + get(key) → GameCharacter   │  ← Always returns clone!
///  │ + listKeys()                 │
///  └──────────────────────────────┘
///             ▲
///             │ uses
///  ┌──────────┴───────────┐
///  │    Client Code       │  ← prototype_main.dart
///  └──────────────────────┘
///
/// ==========================================================================
///
///  SEQUENCE DIAGRAM — تسلسل العمليات
///  ─────────────────────────────────────────────────────────────────────────
///
///  Client               Registry               GameCharacter
///    │                     │                        │
///    │ register("warrior", warrior)                 │
///    │────────────────────►│                        │
///    │                     │── stores reference ───►│
///    │                     │                        │
///    │  get("warrior")     │                        │
///    │────────────────────►│                        │
///    │                     │──── clone() ──────────►│
///    │                     │◄─── new GameCharacter ─│
///    │◄── cloned copy ─────│                        │
///    │                     │                        │
///    │  clone.skills.add() │                        │
///    │────────────────────────────────────────────► │ ← NO effect on original!
///
/// ==========================================================================
///
///  SHALLOW COPY vs DEEP COPY
///  ─────────────────────────────────────────────────────────────────────────
///
///  ❌ Shallow Copy — مشاركة القائمة (خطر!)
///
///  original ──► GameCharacter { skills: ──► ["Fireball"] }
///                                               ▲
///  clone    ──► GameCharacter { skills: ─────────┘  ← نفس القائمة!
///
///  clone.skills.add("Thunder") → يؤثر على الأصل! ⚠️
///
///  ─────────────────────────────────────────────────────────────────────────
///
///  ✅ Deep Copy — نسخة مستقلة (آمن)
///
///  original ──► GameCharacter { skills: ──► ["Fireball"] }
///  clone    ──► GameCharacter { skills: ──► ["Fireball"] } ← نسخة منفصلة!
///
///  clone.skills.add("Thunder") → لا يؤثر على الأصل ✅
///
/// ==========================================================================
