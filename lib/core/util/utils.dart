import 'dart:io';
import 'package:onyxsio/onyxsio.dart';

//

class Utils {
  // static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static date(String date) => DateFormat.yMd().format(DateTime.parse(date));
//
  static dateTime(DateTime date) =>
      DateFormat('yyyy-M-d hh:mm:ss').format(date);
//
  static day(String date) =>
      DateFormat.yMMMMEEEEd().format(DateTime.parse(date));
//
  static formatCurrencySymble({name}) =>
      NumberFormat.simpleCurrency(name: name).currencySymbol;
//
  static formatCurrency({name, amount}) => CurrencyFormat.simpleCurrency(
        locale: Platform.localeName,
        name: name,
        customPattern: '#,###', //\u00a4
      ).format(amount);
//
  static currency({name, amount}) => CurrencyFormat.simpleCurrency(
        locale: Platform.localeName,
        name: name,
        customPattern: '\u00a4 #,###', //
      ).format(amount);
//
  static offerCal({name, amount, offer}) {
    var cal = ((double.parse(amount) * double.parse(offer)) / 100);

    return currency(amount: (double.parse(amount) - cal), name: name);
  }

  //
  static String orderNumber(String number) => number.split('-').first;
  //
  static String adderss(Address a) =>
      '${a.name},\n${a.streetAddress},\n${a.city}, ${a.state},\n${a.postalCode}';

  static String stok(String a) {
    switch (a) {
      case '0':
        return 'Sorry, all items are sold out.';
      case '1':
        return 'Only 1 item left';
      default:
        return 'Only $a items left';
    }
  }
}
