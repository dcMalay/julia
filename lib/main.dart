import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:julia/provider/auth_provider.dart';
import 'package:julia/provider/category_provider.dart';
import 'package:julia/provider/filter_by_location_provider.dart';
import 'package:julia/provider/get_user_details_proider.dart';
import 'package:julia/provider/is_in_wish_list_provider.dart';
import 'package:julia/provider/location_provider.dart';
import 'package:julia/provider/plans_provider.dart';
import 'package:julia/provider/product_details_provider.dart';
import 'package:julia/views/home.dart';
import 'package:julia/views/login_register/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/filtered_by_price_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => PlanProider()),
        ChangeNotifierProvider(create: (context) => IsInWishListProvider()),
        ChangeNotifierProvider(create: (context) => ProducrDetailsProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(
            create: (context) => GetProfileDetailsProvider()),
        ChangeNotifierProvider(create: (context) => LocationFilterProvider()),
        ChangeNotifierProvider(create: (context) => PriceFilterProvider()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              // initialRoute: '/',
              // routes: {
              //   '/': (context) =>
              //       ProductDetailsScreen(productID: "6373d70338034b02fa75d681"),
              // },
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const SplashScreen(),
            );
          }),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 150,
          width: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/juliaLogo.png"),
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);
    if (status) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => const Home(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                      .animate(animation),
              child: child,
            );
          },
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                      .animate(animation),
              child: child,
            );
          },
        ),
      );
    }
  }
}
