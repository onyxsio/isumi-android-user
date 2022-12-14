import 'dart:io';
import 'package:onyxsio/onyxsio.dart';

//

class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
  static formatDateTime(DateTime date) =>
      DateFormat('yyyy-M-d hh:mm:ss').format(date);

  static formatCurrencySymble({name}) =>
      NumberFormat.simpleCurrency(name: name).currencySymbol;

  static formatCurrency({name, amount}) => CurrencyFormat.simpleCurrency(
        locale: Platform.localeName,
        name: name,
        customPattern: '#,###', //\u00a4
      ).format(amount);

  static currency({name, amount}) => CurrencyFormat.simpleCurrency(
        locale: Platform.localeName,
        name: name,
        customPattern: '\u00a4 #,###', //
      ).format(amount);

  static offerCal({name, amount, offer}) {
    var cal = ((double.parse(amount) * double.parse(offer)) / 100);

    return currency(amount: (double.parse(amount) - cal), name: name);
  }
}
