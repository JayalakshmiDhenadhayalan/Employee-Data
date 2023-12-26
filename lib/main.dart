import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sampleemployee/controller/getdata_controller.dart';
import 'package:sampleemployee/view/home_view/home_view.dart';
import 'package:sampleemployee/view/splash_view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(390, 844),
      child: MultiProvider(
        providers: [
            ChangeNotifierProvider(
    create: (_) => getController(),
  ),
        ],

        child: MaterialApp(
          title: 'Employee App',
        theme: ThemeData(scaffoldBackgroundColor: Color(0xff004237)),
          home: SplashScreen(),
        ),
      ),
    );
  }
}

