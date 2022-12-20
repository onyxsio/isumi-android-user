import 'package:flutter/material.dart';
import 'package:isumi/app/screens/authentication/forgotPass/view/forgot_page.dart';
import 'package:isumi/app/screens/authentication/login/login.dart';
import 'package:isumi/app/screens/authentication/sign_up/view/sign_up_page.dart';
import 'package:isumi/app/screens/cart/view/checkout.dart';
import 'package:isumi/app/screens/cart/view/edit_address.dart';
import 'package:isumi/app/screens/cart/view/end_page.dart';
import 'package:isumi/app/screens/cart/view/order_status_page.dart';
import 'package:isumi/app/screens/cart/view/shipping_addres.dart';
import 'package:isumi/app/screens/drawer/page/account_setting.dart';
import 'package:isumi/app/screens/drawer/page/notification_page.dart';
import 'package:isumi/app/screens/drawer/scan/scan_to_review.dart';
import 'package:isumi/app/screens/drawer/page/settings_page.dart';
import 'package:isumi/app/screens/drawer/page/wish_list_page.dart';
import 'package:isumi/app/screens/home/producat_details.dart';
import 'package:isumi/app/screens/main_page.dart';
import 'package:isumi/app/screens/order/view/order_details.dart';
import 'package:isumi/app/screens/profile/view/reviews_page.dart';
// import 'package:isumi/app/screens/Order/view/bill_generate_page.dart';
// import 'package:isumi/app/screens/Order/view/order_details.dart';
// import 'package:isumi/app/screens/home/offer_page.dart';
// import 'package:isumi/app/screens/home/producat_add.dart';
// import 'package:isumi/app/screens/home/producat_details.dart';
// import 'package:isumi/app/screens/home/producat_update.dart';
// import 'package:isumi/app/screens/home/send_arlet.dart';
// import 'package:isumi/app/screens/main_page.dart';
import 'package:onyxsio/onyxsio.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings? settings) {
    final arguments = settings?.arguments;
    switch (settings?.name) {
      // SpalshPage MainPage
      case '/':
        return OpenAndFadeTransition(const Scaffold());

      case '/SignUpPage':
        return OpenAndFadeTransition(const SignUpPage());

      case '/LoginPage':
        return OpenAndFadeTransition(const LoginPage());
      case '/ForgotPassPage':
        return OpenAndFadeTransition(const ForgotPassPage());
      // case '/SendArlet':
      //   return createRoute(child: const SendArlet());
      case '/MainPage':
        return createRoute(child: const MainPage());

      // case '/OrderDetails':
      //   Orders order = arguments as Orders;
      //   return createRoute(child: OrderDetails(order: order));

      // case '/GenerateBill':
      //   Orders order = arguments as Orders;
      //   return createRoute(child: GenerateBill(order: order));

      // case '/OfferPage':
      //   return createRoute(child: const OfferPage());
      case '/ProductDetails':
        Product product = arguments as Product;
        return OpenAndFadeTransition(ProductDetailsPage(product: product));
      case '/OrderStatusPage':
        dynamic data = arguments as dynamic;
        return OpenAndFadeTransition(OrderStatusPage(carts: data));
      case '/ShippingAddressPage':
        return OpenAndFadeTransition(const ShippingAddressPage());
      case '/CheckOutPage':
        return OpenAndFadeTransition(const CheckOutPage());
      case '/EditAddress':
        LAddress? shipTo = arguments as LAddress?;
        return OpenAndFadeTransition(EditAddress(shipTo: shipTo));
      case '/EndPage':
        return OpenAndFadeTransition(const EndPage());
      //
      case '/ScanToReview':
        return OpenAndFadeTransition(const ScanToReview());
      case '/AccountSettingsPage':
        return OpenAndFadeTransition(const AccountSettingsPage());
      case '/WishListPage':
        return OpenAndFadeTransition(const WishListPage());
      case '/SettingsPage':
        return OpenAndFadeTransition(const SettingsPage());
      case '/OrderDetails':
        Orders order = arguments as Orders;
        return OpenAndFadeTransition(OrderDetails(order: order));
      case '/NotificationPage':
        return OpenAndFadeTransition(const NotificationPage());
      //
      case '/ReviewPage':
        return OpenAndFadeTransition(const ReviewPage());
      default:
        // If there is no such named route in the switch statement
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

Route createRoute({required Widget child}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

// routes: {"/": (context) => const NChecking()},
