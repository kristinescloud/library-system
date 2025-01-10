import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4280039747),
      surfaceTint: Color(4282802798),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282408039),
      onPrimaryContainer: Color(4294770175),
      secondary: Color(4283785317),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292733166),
      onSecondaryContainer: Color(4282469457),
      tertiary: Color(4282200135),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284568171),
      onTertiaryContainer: Color(4294966783),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294638074),
      onSurface: Color(4279901212),
      onSurfaceVariant: Color(4282533963),
      outline: Color(4285692027),
      outlineVariant: Color(4290955211),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282609),
      inversePrimary: Color(4289645528),
      primaryFixed: Color(4291422197),
      onPrimaryFixed: Color(4278198057),
      primaryFixedDim: Color(4289645528),
      onPrimaryFixedVariant: Color(4281289558),
      secondaryFixed: Color(4292469994),
      onSecondaryFixed: Color(4279442721),
      secondaryFixedDim: Color(4290627790),
      onSecondaryFixedVariant: Color(4282271821),
      tertiaryFixed: Color(4293975290),
      onTertiaryFixed: Color(4280424236),
      tertiaryFixedDim: Color(4292067549),
      onTertiaryFixedVariant: Color(4283384153),
      surfaceDim: Color(4292532954),
      surfaceBright: Color(4294638074),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294243316),
      surfaceContainer: Color(4293848558),
      surfaceContainerHigh: Color(4293519592),
      surfaceContainerHighest: Color(4293124835),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4280039747),
      surfaceTint: Color(4282802798),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282408039),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282008649),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285232763),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4282200135),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284568171),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294638074),
      onSurface: Color(4279901212),
      onSurfaceVariant: Color(4282270791),
      outline: Color(4284112995),
      outlineVariant: Color(4285955199),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282609),
      inversePrimary: Color(4289645528),
      primaryFixed: Color(4284250501),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282671211),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285232763),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283653731),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4286541705),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4284831343),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292532954),
      surfaceBright: Color(4294638074),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294243316),
      surfaceContainer: Color(4293848558),
      surfaceContainerHigh: Color(4293519592),
      surfaceContainerHighest: Color(4293124835),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278593072),
      surfaceTint: Color(4282802798),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4281026385),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279837736),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282008649),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4280884531),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283121237),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294638074),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280231207),
      outline: Color(4282270791),
      outlineVariant: Color(4282270791),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282609),
      inversePrimary: Color(4292080127),
      primaryFixed: Color(4281026385),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4279447611),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282008649),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280561203),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283121237),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281608254),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292532954),
      surfaceBright: Color(4294638074),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294243316),
      surfaceContainer: Color(4293848558),
      surfaceContainerHigh: Color(4293519592),
      surfaceContainerHighest: Color(4293124835),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289645528),
      surfaceTint: Color(4289645528),
      onPrimary: Color(4279710782),
      primaryContainer: Color(4280697677),
      onPrimaryContainer: Color(4290435301),
      secondary: Color(4290627790),
      onSecondary: Color(4280824374),
      secondaryContainer: Color(4281811270),
      onSecondaryContainer: Color(4291548892),
      tertiary: Color(4292067549),
      onTertiary: Color(4281871170),
      tertiaryContainer: Color(4282923602),
      onTertiaryContainer: Color(4292988395),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279374868),
      onSurface: Color(4293124835),
      onSurfaceVariant: Color(4290955211),
      outline: Color(4287402645),
      outlineVariant: Color(4282533963),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293124835),
      inversePrimary: Color(4282802798),
      primaryFixed: Color(4291422197),
      onPrimaryFixed: Color(4278198057),
      primaryFixedDim: Color(4289645528),
      onPrimaryFixedVariant: Color(4281289558),
      secondaryFixed: Color(4292469994),
      onSecondaryFixed: Color(4279442721),
      secondaryFixedDim: Color(4290627790),
      onSecondaryFixedVariant: Color(4282271821),
      tertiaryFixed: Color(4293975290),
      onTertiaryFixed: Color(4280424236),
      tertiaryFixedDim: Color(4292067549),
      onTertiaryFixedVariant: Color(4283384153),
      surfaceDim: Color(4279374868),
      surfaceBright: Color(4281874746),
      surfaceContainerLowest: Color(4279045647),
      surfaceContainerLow: Color(4279901212),
      surfaceContainer: Color(4280164385),
      surfaceContainerHigh: Color(4280887851),
      surfaceContainerHighest: Color(4281611574),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289908701),
      surfaceTint: Color(4289645528),
      onPrimary: Color(4278196514),
      primaryContainer: Color(4286092705),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290890962),
      onSecondary: Color(4279048220),
      secondaryContainer: Color(4287074968),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4292330721),
      onTertiary: Color(4280095014),
      tertiaryContainer: Color(4288449446),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374868),
      onSurface: Color(4294703867),
      onSurfaceVariant: Color(4291218383),
      outline: Color(4288586919),
      outlineVariant: Color(4286481543),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293124835),
      inversePrimary: Color(4281355351),
      primaryFixed: Color(4291422197),
      onPrimaryFixed: Color(4278195227),
      primaryFixedDim: Color(4289645528),
      onPrimaryFixedVariant: Color(4280105540),
      secondaryFixed: Color(4292469994),
      onSecondaryFixed: Color(4278719255),
      secondaryFixedDim: Color(4290627790),
      onSecondaryFixedVariant: Color(4281153596),
      tertiaryFixed: Color(4293975290),
      onTertiaryFixed: Color(4279766049),
      tertiaryFixedDim: Color(4292067549),
      onTertiaryFixedVariant: Color(4282265928),
      surfaceDim: Color(4279374868),
      surfaceBright: Color(4281874746),
      surfaceContainerLowest: Color(4279045647),
      surfaceContainerLow: Color(4279901212),
      surfaceContainer: Color(4280164385),
      surfaceContainerHigh: Color(4280887851),
      surfaceContainerHighest: Color(4281611574),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294376447),
      surfaceTint: Color(4289645528),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4289908701),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294376447),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290890962),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965755),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4292330721),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374868),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294376447),
      outline: Color(4291218383),
      outlineVariant: Color(4291218383),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293124835),
      inversePrimary: Color(4279184952),
      primaryFixed: Color(4291751161),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4289908701),
      onPrimaryFixedVariant: Color(4278196514),
      secondaryFixed: Color(4292733422),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290890962),
      onSecondaryFixedVariant: Color(4279048220),
      tertiaryFixed: Color(4294238462),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4292330721),
      onTertiaryFixedVariant: Color(4280095014),
      surfaceDim: Color(4279374868),
      surfaceBright: Color(4281874746),
      surfaceContainerLowest: Color(4279045647),
      surfaceContainerLow: Color(4279901212),
      surfaceContainer: Color(4280164385),
      surfaceContainerHigh: Color(4280887851),
      surfaceContainerHighest: Color(4281611574),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
