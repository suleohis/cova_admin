import 'package:firebase_auth/firebase_auth.dart';

import 'controllers/users_controller.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/constants/style.dart';
import 'package:cova_admin_dashboard/controllers/menu_controller.dart'
    as menu_controller;
import 'package:cova_admin_dashboard/controllers/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routing/routes.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(UsersController());
  Get.put(menu_controller.MenuController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? RouteHelper.getSignInRoute()
          : RouteHelper.getInitialRoute(),
      unknownRoute: RouteHelper.getUnknownPage(),
      getPages: RouteHelper.routes,
      debugShowCheckedModeBanner: false,
      title: 'HostKing',
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          // TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          // TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primarySwatch: Colors.blue,
      ),
      // home: AuthenticationPage(),
    );
  }
}
