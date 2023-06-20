

import 'package:admin_petco/screens/details/details_screen.dart';
import 'package:admin_petco/screens/home/home_screen.dart';
import 'package:admin_petco/screens/login_success/login_success_screen.dart';
import 'package:admin_petco/screens/main_page_manager.dart';
import 'package:admin_petco/screens/profile/profile_screen.dart';
import 'package:admin_petco/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/widgets.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => const SignInScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  MainPageManager.routeName:(context) => const MainPageManager(),
};
