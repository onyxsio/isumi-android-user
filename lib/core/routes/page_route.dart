import 'package:flutter/material.dart';
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
      // case '/':
      //   return createRoute(child: const SpalshPage());
      // case '/SendArlet':
      //   return createRoute(child: const SendArlet());
      // case '/MainPage':
      //   return createRoute(child: const MainPage());

      // case '/OrderDetails':
      //   Orders order = arguments as Orders;
      //   return createRoute(child: OrderDetails(order: order));

      // case '/GenerateBill':
      //   Orders order = arguments as Orders;
      //   return createRoute(child: GenerateBill(order: order));

      // case '/OfferPage':
      //   return createRoute(child: const OfferPage());
      // case '/ProductDetails':
      //   Product product = arguments as Product;
      //   return createRoute(child: ProductDetailsPage(product: product));
      // case '/ProductUpdate':
      //   Product product = arguments as Product;
      //   return createRoute(child: ProductUpdatePage(product: product));
      // case '/ProductAdd':
      //   return createRoute(child: const ProductAddPage());
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