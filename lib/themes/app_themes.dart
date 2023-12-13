import 'package:flutter/material.dart';
import 'package:kaylin_studio/themes/app_colors.dart';

class AppThemes {
  static ThemeData get dark {
    return ThemeData(
      appBarTheme:
          const AppBarTheme(backgroundColor: AppColors.branchSunOrange),
      primaryColor: AppColors.branchStrongBlue,
      scaffoldBackgroundColor: Colors.grey[850],
      backgroundColor: Colors.grey[850],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          // textStyle: MaterialStateProperty.resolveWith(
          //     (states) => const TextStyle(color: Colors.white)),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) => const Color(0XFFFFFFFF),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => AppColors.branchStrongBlue,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith(
              (states) => const TextStyle(color: Colors.white)),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) => const Color(0XFFFFFFFF),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => AppColors.branchStrongBlue,
          ),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.white, fontSize: 20),
        bodyMedium: TextStyle(color: Colors.white, fontSize: 15),
        bodySmall: TextStyle(color: Colors.white, fontSize: 12),
        bodyLarge: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  static ThemeData get light {
    return ThemeData(
      appBarTheme:
          const AppBarTheme(backgroundColor: AppColors.branchSunOrange),
      primaryColor: AppColors.branchStrongBlue,
      scaffoldBackgroundColor: Colors.grey[300],
      backgroundColor: Colors.grey[300],
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith(
              (states) => const TextStyle(color: Colors.white)),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) => const Color(0XFFFFFFFF),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => AppColors.branchStrongBlue,
          ),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.white, fontSize: 20),
        bodyMedium: TextStyle(color: Colors.white, fontSize: 15),
        bodySmall: TextStyle(color: Colors.white, fontSize: 12),
        bodyLarge: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
