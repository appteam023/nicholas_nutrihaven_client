import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Config/AppRoutes/routes_imports.dart';
import 'Utils/Const/color_const.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: themeColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: true,
    ),
  );
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        useInheritedMediaQuery: true,
        minTextAdapt: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            getPages: AppRoutes.routes,
            // initialRoute: AppRoutes.splash,
            initialRoute: AppRoutes.splash,
            theme: ThemeData(
                fontFamily: 'Product Sans',
                primaryColor: primary,
                bottomSheetTheme: const BottomSheetThemeData(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.white,
                  surfaceTintColor: Colors.white,
                ),
                canvasColor: Colors.white,
                textTheme: TextTheme(
                  headlineLarge: TextStyle(
                    fontFamily: 'Jockey One',
                    fontSize: 40.sp,
                    color: secondary,
                    fontWeight: FontWeight.bold,
                  ),
                  headlineMedium: TextStyle(
                    fontFamily: 'Jockey One',
                    fontSize: 30.sp,
                    color: secondary,
                    fontWeight: FontWeight.w500,
                  ),
                  headlineSmall: TextStyle(
                    fontFamily: 'Jockey One',
                    fontSize: 26.sp,
                    color: secondary,
                    fontWeight: FontWeight.w500,
                  ),

                  ///Titles are all bold but same size as body text
                  // Title
                  titleLarge: TextStyle(
                    fontFamily: 'Jockey One',
                    fontSize: 18.sp,
                    color: secondary,
                    fontWeight: FontWeight.bold,
                  ),
                  titleMedium: TextStyle(
                    fontSize: 16.sp,
                    color: secondary,
                    fontWeight: FontWeight.bold,
                  ),
                  titleSmall: TextStyle(
                    fontSize: 14.sp,
                    color: secondary,
                    fontWeight: FontWeight.normal,
                  ),

                  ///Body text are all black and has same weight as white in headline
                  bodyLarge: TextStyle(
                    fontSize: 18.sp,
                    color: primary,
                    fontWeight: FontWeight.normal,
                  ),
                  bodyMedium: TextStyle(
                    fontSize: 16.sp,
                    color: primary,
                    fontWeight: FontWeight.normal,
                  ),
                  bodySmall: TextStyle(
                    fontSize: 14.sp,
                    color: primary,
                    fontWeight: FontWeight.normal,
                  ),

                  /// Label
                  labelLarge: TextStyle(
                    fontSize: 18.sp,
                    color: primary,
                    fontWeight: FontWeight.bold,
                  ),
                  labelMedium: TextStyle(
                    fontSize: 16.sp,
                    color: primary,
                    fontWeight: FontWeight.normal,
                  ),
                  labelSmall: TextStyle(
                    fontSize: 14.sp,
                    color: primary,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                ///Scaffold
                scaffoldBackgroundColor: Colors.white,

                ///APP BAR
                appBarTheme: AppBarTheme(
                  elevation: 0,
                  backgroundColor: themeColor,
                  titleTextStyle: GoogleFonts.inter(
                    color: secondary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                ///Elevated Button
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: yellow),
                    borderRadius: BorderRadius.circular(30.0.r),
                  ),
                  fixedSize: Size(130.w, 40.h),
                  foregroundColor: yellow,
                  elevation: 0,
                  animationDuration: const Duration(milliseconds: 700),
                  backgroundColor: secondary,
                  textStyle: TextStyle(
                    fontSize: 20.sp,
                  ),
                )),

                ///Divider
                dividerTheme: DividerThemeData(
                  thickness: 1,
                  color: themeColor,
                ),

                ///Icon
                iconTheme: const IconThemeData(color: Color(0xFF333333)),

                ///Input Decoration
                inputDecorationTheme: InputDecorationTheme(
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xFF808191),
                  ),
                  filled: true,
                  fillColor: secondary,
                  prefixIconColor: const Color(0xFF272B35),
                  suffixIconColor: const Color(0xFFA5A5A5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500.r),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500.r),
                    borderSide: const BorderSide(
                      color: Color(0xFFA5A5A5),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500.r),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                checkboxTheme: CheckboxThemeData(
                  fillColor: WidgetStateProperty.resolveWith(
                    (Set<WidgetState> states) {
                      // Customize the fill color based on the checkbox's state
                      if (states.contains(WidgetState.selected)) {
                        return const Color(0xFFA5A5A5); // Color when checked
                      }
                      return Color(0xFFFFFFFF); // Color when unchecked
                    },
                  ),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: primary,
                    textStyle: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        height: 1.5),
                  ),
                )),
          );
        });
  }
}
