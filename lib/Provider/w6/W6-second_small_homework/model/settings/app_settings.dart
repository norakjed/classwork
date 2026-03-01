import 'dart:ui';

enum ThemeColor {
  blue(color: Color.fromARGB(255, 34, 118, 229)),
  pink(color: Color.fromARGB(255, 229, 158, 221)),
  green(color: Color.fromARGB(255, 156, 202, 8));

  const ThemeColor({required this.color});

  final Color color;
  Color get backgroundColor => color.withAlpha(50);
}

class AppSettings {
  final ThemeColor themeColor;
  final bool darkMode;
  final bool explicitContentEnable;
  
  AppSettings({
    required this.themeColor,
    required this.darkMode,
    required this.explicitContentEnable,
  });

  AppSettings copyWith({
    ThemeColor? themeColor,
    bool? darkMode,
    bool? explicitContentEnable,
  }) {
    return AppSettings(
      themeColor: themeColor ?? this.themeColor,
      darkMode: darkMode ?? this.darkMode,
      explicitContentEnable:
          explicitContentEnable ?? this.explicitContentEnable,
    );
  }
}
