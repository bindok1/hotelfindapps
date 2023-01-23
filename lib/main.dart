import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelgo/config/app_color.dart';
import 'package:hotelgo/config/app_route.dart';
import 'package:hotelgo/config/session.dart';
import 'package:hotelgo/model/user.dart';
import 'package:hotelgo/page/chechkout_page.dart';
import 'package:hotelgo/page/checkout_succes_page.dart';
import 'package:hotelgo/page/detail_booking_page.dart';
import 'package:hotelgo/page/detail_page.dart';
import 'package:hotelgo/page/home_page.dart';
import 'package:hotelgo/page/intro_page.dart';
import 'package:hotelgo/page/sign_in.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting('en_US');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: AppColor.backgroundScaffold,
          primaryColor: AppColor.primary,
          colorScheme: const ColorScheme.light(
              primary: AppColor.primary, secondary: AppColor.secondary)),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) {
          //gunakan FutureBuilder utk menangkap return session
          return FutureBuilder(
            future: Session.getUser(),
            builder: (context, AsyncSnapshot<User> snapshot) {
              if (snapshot.data == null || snapshot.data!.id == null) {
                return IntroPage();
              } else {
                return HomePage();
              }
            },
          );
        },
        ApprRoute.intro: (context) => const IntroPage(),
        ApprRoute.home: (context) => HomePage(),
        ApprRoute.signin: (context) => SignIn(),
        ApprRoute.detail: (context) => DetailPage(),
        ApprRoute.checkout: (context) => CheckOutPage(),
        ApprRoute.checkoutSucccess: (context) => CheckOutSucccesPage(),
        ApprRoute.detailBooking: (context) => DetailBookingPage(),
      },
    );
  }
}
