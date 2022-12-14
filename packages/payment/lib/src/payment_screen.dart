import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import '.env.dart';

// Add a Tax fee 3.6 for stripe => recomend 3.64
class PaymentGate {
  PaymentGate._init();

  static init() async {
    // set the publishable key for Stripe
    Stripe.publishableKey = stripe_Publishable_Key;
    await Stripe.instance.applySettings();
    Stripe.merchantIdentifier = 'isumi';
  }

  //
  static Future<String> onPayment(
      {required String email,
      required double amount,
      required BuildContext context}) async {
    try {
      // 1. fetch Intent Client Secret from backend
      final response = await fetchIntentClientSecret(email, amount, context);

      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: response['paymentIntent'],
        merchantDisplayName: 'isumi SHOP',
        customerId: response['customer'],
        customerEphemeralKeySecret: response['ephemeralKey'],
      ));
      // 3.
      await Stripe.instance.presentPaymentSheet();
      // 4.
      return 'successful';
    } catch (e) {
      if (e is StripeException) {
        return e.error.localizedMessage!;
      } else {
        return e.toString();
      }
    }
  }

  //
  static Future<Map<String, dynamic>> fetchIntentClientSecret(
      email, amount, context) async {
    try {
      // 1. Create a payment intent on the server
      final response = await http.post(Uri.parse(stripeUrl), body: {
        'email': email,
        'amount': amount.toString(),
        'currency': 'JPY'
      });

      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse.toString());
      return jsonResponse;
    } catch (e) {
      return {'error': e};
    }
  }
}
