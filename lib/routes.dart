import 'package:go_router/go_router.dart';
import 'package:shop_app/screens/add_product/add_product_screen.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'models/Product.dart';
import 'screens/sign_up/sign_up_screen.dart';

final GoRouter router = GoRouter(

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/SignInScreen',
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      path: '/HomeScreen',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/ForgotPasswordScreen',
      builder: (context, state) => ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/LoginSuccessScreen',
      builder: (context, state) => LoginSuccessScreen(),
    ),
    GoRoute(
      path: '/SignUpScreen',
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: '/CompleteProfileScreen',
      builder: (context, state) => CompleteProfileScreen(),
    ),
    GoRoute(
      path: '/OtpScreen',
      builder: (context, state) => OtpScreen(),
    ),
    GoRoute(
      path: '/DetailsScreen',
      builder: (context, state) {
        Product product = state.extra as Product;
        return DetailsScreen(
          product: product,
        );
      },
    ),
    GoRoute(
      path: '/CartScreen',
      builder: (context, state) => CartScreen(),
    ),
    GoRoute(
      path: '/ProfileScreen',
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: '/AddProduct',
      builder: (context, state) => const AddProduct(),
    ),
  ],



);
