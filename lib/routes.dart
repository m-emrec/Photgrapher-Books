import 'package:flutter/material.dart';
import 'package:photo_book/screens/auth_screen.dart';
import 'package:photo_book/screens/forgot_password_page.dart';
import 'package:photo_book/screens/home_page.dart';
import 'package:photo_book/screens/login_page.dart';
import 'package:photo_book/screens/sign_up_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  "/": (p0) => AuthScreen(),
  SignUpPage.routeName: (p0) => SignUpPage(),
  LoginPage.routeName: (p0) => LoginPage(),
  HomePage.routeName: (p0) => HomePage(),
  ForgotPasswordPage.routeName: (p0) => ForgotPasswordPage(),
};
