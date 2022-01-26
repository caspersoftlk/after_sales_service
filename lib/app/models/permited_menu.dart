class PermitedMenu{
  final String role;
  final String menu;

//<editor-fold desc="Data Methods">

  const PermitedMenu({
    required this.role,
    required this.menu,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PermitedMenu &&
          runtimeType == other.runtimeType &&
          role == other.role &&
          menu == other.menu);

  @override
  int get hashCode => role.hashCode ^ menu.hashCode;

  @override
  String toString() {
    return 'PermitedMenu{' + ' role: $role,' + ' menu: $menu,' + '}';
  }

  PermitedMenu copyWith({
    String? role,
    String? menu,
  }) {
    return PermitedMenu(
      role: role ?? this.role,
      menu: menu ?? this.menu,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': this.role,
      'menu': this.menu,
    };
  }

  factory PermitedMenu.fromMap(Map<String, dynamic> map) {
    return PermitedMenu(
      role: map['role'] as String,
      menu: map['menu'] as String,
    );
  }

//</editor-fold>
}