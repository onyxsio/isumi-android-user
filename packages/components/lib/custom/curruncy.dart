// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'dart:math';

import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:intl/src/intl/constants.dart' as constants;
import 'package:intl/src/intl/number_format_parser.dart';
import 'package:intl/src/intl_helpers.dart' as helpers;

/// the appropriate pattern (e.g. currency)
typedef _PatternGetter = String? Function(NumberSymbols);

class CurrencyFormat {
  /// Variables to determine how number printing behaves.
  final String negativePrefix;
  final String positivePrefix;
  final String negativeSuffix;
  final String positiveSuffix;

  int _groupingSize;

  int _finalGroupingSize;

  /// Set to true if the format has explicitly set the grouping size.
  final bool _decimalSeparatorAlwaysShown;
  final bool _useSignForPositiveExponent;
  final bool _useExponentialNotation;

  // final bool _isForCurrency;

  int maximumIntegerDigits;
  int minimumIntegerDigits;
  int maximumFractionDigits;
  int minimumFractionDigits;
  int minimumExponentDigits;
  int? _significantDigits;

  ///  How many significant digits should we print.
  ///
  ///  Note that if significantDigitsInUse is the default false, this
  ///  will be ignored.
  int? get significantDigits => _significantDigits;
  set significantDigits(int? x) {
    _significantDigits = x;
    significantDigitsInUse = true;
  }

  bool significantDigitsInUse = false;

  /// For percent and permille, what are we multiplying by in order to
  /// get the printed value, e.g. 100 for percent.
  final int multiplier;

  /// How many digits are there in the [multiplier].
  final int _multiplierDigits;

  /// Stores the pattern used to create this format. This isn't used, but
  /// is helpful in debugging.
  final String? _pattern;

  /// The locale in which we print numbers.
  final String _locale;

  /// Caches the symbols used for our locale.
  final NumberSymbols _symbols;

  /// The name of the currency to print, in ISO 4217 form.
  String? currencyName;

  /// The symbol to be used when formatting this as currency.
  ///
  /// For example, "$", "US$", or "€".
  final String currencySymbol;

  final int? decimalDigits;

  final StringBuffer _buffer = StringBuffer();

  factory CurrencyFormat.simpleCurrency(
      {String? locale,
      String? name,
      int? decimalDigits,
      String? customPattern}) {
    return CurrencyFormat._forPattern(
        locale, (x) => customPattern ?? x.CURRENCY_PATTERN,
        name: name,
        decimalDigits: decimalDigits,
        lookupSimpleCurrencySymbol: true,
        isForCurrency: true);
  }

  factory CurrencyFormat._forPattern(String? locale, _PatternGetter getPattern,
      {String? name,
      String? currencySymbol,
      int? decimalDigits,
      bool lookupSimpleCurrencySymbol = false,
      bool isForCurrency = false}) {
    locale = helpers.verifiedLocale(locale, localeExists, null)!;
    var symbols = numberFormatSymbols[locale] as NumberSymbols;
    var localeZero = symbols.ZERO_DIGIT.codeUnitAt(0);
    var zeroOffset = localeZero - constants.asciiZeroCodeUnit;
    name ??= symbols.DEF_CURRENCY_CODE;
    if (currencySymbol == null && lookupSimpleCurrencySymbol) {
      currencySymbol = constants.simpleCurrencySymbols[name];
    }
    currencySymbol ??= name;

    var pattern = getPattern(symbols);

    return CurrencyFormat._(
        name,
        currencySymbol,
        // isForCurrency,
        locale,
        localeZero,
        pattern,
        symbols,
        zeroOffset,
        NumberFormatParser.parse(symbols, pattern, isForCurrency,
            currencySymbol, name, decimalDigits));
  }

  CurrencyFormat._(
      this.currencyName,
      this.currencySymbol,
      // this._isForCurrency,
      this._locale,
      this.localeZero,
      this._pattern,
      this._symbols,
      this._zeroOffset,
      NumberFormatParseResult result)
      : positivePrefix = result.positivePrefix,
        negativePrefix = result.negativePrefix,
        positiveSuffix = result.positiveSuffix,
        negativeSuffix = result.negativeSuffix,
        multiplier = result.multiplier,
        _multiplierDigits = result.multiplierDigits,
        _useExponentialNotation = result.useExponentialNotation,
        minimumExponentDigits = result.minimumExponentDigits,
        maximumIntegerDigits = result.maximumIntegerDigits,
        minimumIntegerDigits = result.minimumIntegerDigits,
        maximumFractionDigits = result.maximumFractionDigits,
        minimumFractionDigits = result.minimumFractionDigits,
        _groupingSize = result.groupingSize,
        _finalGroupingSize = result.finalGroupingSize,
        _useSignForPositiveExponent = result.useSignForPositiveExponent,
        _decimalSeparatorAlwaysShown = result.decimalSeparatorAlwaysShown,
        decimalDigits = result.decimalDigits;

  /// Return the locale code in which we operate, e.g. 'en_US' or 'pt'.
  String get locale => _locale;

  /// Return true if the locale exists, or if it is null. The null case
  /// is interpreted to mean that we use the default locale.
  static bool localeExists(localeName) {
    if (localeName == null) return false;
    return numberFormatSymbols.containsKey(localeName);
  }

  /// Return the symbols which are used in our locale. Cache them to avoid
  /// repeated lookup.
  NumberSymbols get symbols => _symbols;

  /// Format [number] according to our pattern and return the formatted string.
  String format(number) {
    if (_isNaN(number)) return symbols.NAN;
    if (_isInfinite(number)) {
      return '${_signPrefix(number)} ${symbols.INFINITY}';
    }

    _add(_signPrefix(number));
    _formatNumber(number.abs());
    _add(_signSuffix(number));

    var result = _buffer.toString();
    _buffer.clear();
    return result;
  }

  /// Parse the number represented by the string. If it's not
  /// parseable, throws a [FormatException].
  // num parse(String text) => NumberParser(this, text).value!;

  /// Format the main part of the number in the form dictated by the pattern.
  void _formatNumber(number) {
    if (_useExponentialNotation) {
      _formatExponential(number);
    } else {
      _formatFixed(number);
    }
  }

  /// Format the number in exponential notation.
  void _formatExponential(num number) {
    if (number == 0.0) {
      _formatFixed(number);
      _formatExponent(0);
      return;
    }

    var exponent = (log(number) / _ln10).floor();
    var mantissa = number / pow(10.0, exponent);

    if (maximumIntegerDigits > 1 &&
        maximumIntegerDigits > minimumIntegerDigits) {
      // A repeating range is defined; adjust to it as follows.
      // If repeat == 3, we have 6,5,4=>3; 3,2,1=>0; 0,-1,-2=>-3;
      // -3,-4,-5=>-6, etc. This takes into account that the
      // exponent we have here is off by one from what we expect;
      // it is for the format 0.MMMMMx10^n.
      while ((exponent % maximumIntegerDigits) != 0) {
        mantissa *= 10;
        exponent--;
      }
    } else {
      // No repeating range is defined, use minimum integer digits.
      if (minimumIntegerDigits < 1) {
        exponent++;
        mantissa /= 10;
      } else {
        exponent -= minimumIntegerDigits - 1;
        mantissa *= pow(10, minimumIntegerDigits - 1);
      }
    }
    _formatFixed(mantissa);
    _formatExponent(exponent);
  }

  /// Format the exponent portion, e.g. in "1.3e-5" the "e-5".
  void _formatExponent(num exponent) {
    _add(symbols.EXP_SYMBOL);
    if (exponent < 0) {
      exponent = -exponent;
      _add(symbols.MINUS_SIGN);
    } else if (_useSignForPositiveExponent) {
      _add(symbols.PLUS_SIGN);
    }
    _pad(minimumExponentDigits, exponent.toString());
  }

  static final _maxInt = 1 is double ? pow(2, 52) : 1.0e300.floor();
  static final _maxDigits = (log(_maxInt) / log(10)).ceil();

  /// Helpers to check numbers that don't conform to the [num] interface,
  /// e.g. Int64
  bool _isInfinite(number) => number is num ? number.isInfinite : false;
  bool _isNaN(number) => number is num ? number.isNaN : false;

  /// Helper to get the floor of a number which might not be num. This should
  /// only ever be called with an argument which is positive, or whose abs()
  ///  is negative. The second case is the maximum negative value on a
  ///  fixed-length integer. Since they are integers, they are also their own
  ///  floor.
  dynamic _floor(dynamic number) {
    if (number.isNegative && !number.abs().isNegative) {
      throw ArgumentError(
          'Internal error: expected positive number, got $number');
    }
    return (number is num) ? number.floor() : number ~/ 1;
  }

  /// Helper to round a number which might not be num.
  dynamic _round(dynamic number) {
    if (number is num) {
      if (number.isInfinite) {
        return _maxInt;
      } else {
        return number.round();
      }
    } else if (number.remainder(1) == 0) {
      // Not a normal number, but int-like, e.g. Int64
      return number;
    } else {
      var basic = _floor(number);
      var fraction = (number - basic).toDouble().round();
      return fraction == 0 ? number : number + fraction;
    }
  }

  // Return the number of digits left of the decimal place in [number].
  static int numberOfIntegerDigits(number) {
    var simpleNumber = number.toDouble().abs();
    // It's unfortunate that we have to do this, but we get precision errors
    // that affect the result if we use logs, e.g. 1000000
    if (simpleNumber < 10) return 1;
    if (simpleNumber < 100) return 2;
    if (simpleNumber < 1000) return 3;
    if (simpleNumber < 10000) return 4;
    if (simpleNumber < 100000) return 5;
    if (simpleNumber < 1000000) return 6;
    if (simpleNumber < 10000000) return 7;
    if (simpleNumber < 100000000) return 8;
    if (simpleNumber < 1000000000) return 9;
    if (simpleNumber < 10000000000) return 10;
    if (simpleNumber < 100000000000) return 11;
    if (simpleNumber < 1000000000000) return 12;
    if (simpleNumber < 10000000000000) return 13;
    if (simpleNumber < 100000000000000) return 14;
    if (simpleNumber < 1000000000000000) return 15;
    if (simpleNumber < 10000000000000000) return 16;
    // We're past the point where being off by one on the number of digits
    // will affect the pattern, so now we can use logs.
    return max(1, (log(simpleNumber) / _ln10).ceil());
  }

  int _fractionDigitsAfter(int remainingSignificantDigits) =>
      max(0, remainingSignificantDigits);

  /// Format the basic number portion, including the fractional digits.
  void _formatFixed(dynamic number) {
    dynamic integerPart;
    int fractionPart;
    int extraIntegerDigits;
    var fractionDigits = maximumFractionDigits;

    var power = 0;
    int digitMultiplier;

    if (_isInfinite(number)) {
      integerPart = number.toInt();
      extraIntegerDigits = 0;
      fractionPart = 0;
    } else {
      // We have three possible pieces. First, the basic integer part. If this
      // is a percent or permille, the additional 2 or 3 digits. Finally the
      // fractional part.
      // We avoid multiplying the number because it might overflow if we have
      // a fixed-size integer type, so we extract each of the three as an
      // integer pieces.
      integerPart = _floor(number);
      var fraction = number - integerPart;
      if (fraction.toInt() != 0) {
        // If the fractional part leftover is > 1, presumbly the number
        // was too big for a fixed-size integer, so leave it as whatever
        // it was - the obvious thing is a double.
        integerPart = number;
        fraction = 0;
      }

      /// If we have significant digits, recalculate the number of fraction
      /// digits based on that.
      if (significantDigitsInUse) {
        var significantDigits = this.significantDigits!;
        var integerLength = numberOfIntegerDigits(integerPart);
        var remainingSignificantDigits =
            significantDigits - _multiplierDigits - integerLength;
        fractionDigits = _fractionDigitsAfter(remainingSignificantDigits);
        if (remainingSignificantDigits < 0) {
          // We may have to round.
          var divideBy = pow(10, integerLength - significantDigits);
          integerPart = (integerPart / divideBy).round() * divideBy;
        }
      }
      power = pow(10, fractionDigits) as int;
      digitMultiplier = power * multiplier;

      // Multiply out to the number of decimal places and the percent, then
      // round. For fixed-size integer types this should always be zero, so
      // multiplying is OK.
      var remainingDigits = _round(fraction * digitMultiplier).toInt();
      // However, in rounding we may overflow into the main digits.
      if (remainingDigits >= digitMultiplier) {
        integerPart++;
        remainingDigits -= digitMultiplier;
      }
      // Separate out the extra integer parts from the fraction part.
      extraIntegerDigits = remainingDigits ~/ power;
      fractionPart = remainingDigits % power;
    }

    var integerDigits = _integerDigits(integerPart, extraIntegerDigits);
    var digitLength = integerDigits.length;
    var fractionPresent =
        fractionDigits > 0 && (minimumFractionDigits > 0 || fractionPart > 0);

    if (_hasIntegerDigits(integerDigits)) {
      // Add the padding digits to the regular digits so that we get grouping.
      var padding = '0' * (minimumIntegerDigits - digitLength);
      integerDigits = '$padding$integerDigits';
      digitLength = integerDigits.length;
      for (var i = 0; i < digitLength; i++) {
        _addDigit(integerDigits.codeUnitAt(i));
        _group(digitLength, i);
      }
    } else if (!fractionPresent) {
      // If neither fraction nor integer part exists, just print zero.
      _addZero();
    }

    _decimalSeparator(fractionPresent);
    _formatFractionPart((fractionPart + power).toString());
  }

  /// Compute the raw integer digits which will then be printed with
  /// grouping and translated to localized digits.
  String _integerDigits(integerPart, extraIntegerDigits) {
    // If the integer part is larger than the maximum integer size
    // (2^52 on Javascript, 2^63 on the VM) it will lose precision,
    // so pad out the rest of it with zeros.
    var paddingDigits = '';
    if (integerPart is num && integerPart > _maxInt) {
      var howManyDigitsTooBig = (log(integerPart) / _ln10).ceil() - _maxDigits;
      num divisor = pow(10, howManyDigitsTooBig).round();
      // pow() produces 0 if the result is too large for a 64-bit int.
      // If that happens, use a floating point divisor instead.
      if (divisor == 0) divisor = pow(10.0, howManyDigitsTooBig);
      paddingDigits = '0' * howManyDigitsTooBig.toInt();
      integerPart = (integerPart / divisor).truncate();
    }

    var extra = extraIntegerDigits == 0 ? '' : extraIntegerDigits.toString();
    var intDigits = _mainIntegerDigits(integerPart);
    var paddedExtra =
        intDigits.isEmpty ? extra : extra.padLeft(_multiplierDigits, '0');
    return '$intDigits$paddedExtra$paddingDigits';
  }

  /// The digit string of the integer part. This is the empty string if the
  /// integer part is zero and otherwise is the toString() of the integer
  /// part, stripping off any minus sign.
  String _mainIntegerDigits(integer) {
    if (integer == 0) return '';
    var digits = integer.toString();
    if (significantDigitsInUse && digits.length > significantDigits!) {
      digits = digits.substring(0, significantDigits) +
          ''.padLeft(digits.length - significantDigits!, '0');
    }
    // If we have a fixed-length int representation, it can have a negative
    // number whose negation is also negative, e.g. 2^-63 in 64-bit.
    // Remove the minus sign.
    return digits.startsWith('-') ? digits.substring(1) : digits;
  }

  /// Format the part after the decimal place in a fixed point number.
  void _formatFractionPart(String fractionPart) {
    var fractionLength = fractionPart.length;
    while (fractionPart.codeUnitAt(fractionLength - 1) ==
            constants.asciiZeroCodeUnit &&
        fractionLength > minimumFractionDigits + 1) {
      fractionLength--;
    }
    for (var i = 1; i < fractionLength; i++) {
      _addDigit(fractionPart.codeUnitAt(i));
    }
  }

  /// Print the decimal separator if appropriate.
  void _decimalSeparator(bool fractionPresent) {
    if (_decimalSeparatorAlwaysShown || fractionPresent) {
      _add(symbols.DECIMAL_SEP);
    }
  }

  bool _hasIntegerDigits(String digits) =>
      digits.isNotEmpty || minimumIntegerDigits > 0;

  void _add(String x) {
    _buffer.write(x);
  }

  void _addZero() {
    _buffer.write(symbols.ZERO_DIGIT);
  }

  void _addDigit(int x) {
    _buffer.writeCharCode(x + _zeroOffset);
  }

  void _pad(int numberOfDigits, String basic) {
    if (_zeroOffset == 0) {
      _buffer.write(basic.padLeft(numberOfDigits, '0'));
    } else {
      _slowPad(numberOfDigits, basic);
    }
  }

  /// Print padding up to [numberOfDigits] above what's included in [basic].
  void _slowPad(int numberOfDigits, String basic) {
    for (var i = 0; i < numberOfDigits - basic.length; i++) {
      _add(symbols.ZERO_DIGIT);
    }
    for (var i = 0; i < basic.length; i++) {
      _addDigit(basic.codeUnitAt(i));
    }
  }

  void _group(int totalLength, int position) {
    var distanceFromEnd = totalLength - position;
    if (distanceFromEnd <= 1 || _groupingSize <= 0) return;
    if (distanceFromEnd == _finalGroupingSize + 1) {
      _add(symbols.GROUP_SEP);
    } else if ((distanceFromEnd > _finalGroupingSize) &&
        (distanceFromEnd - _finalGroupingSize) % _groupingSize == 1) {
      _add(symbols.GROUP_SEP);
    }
  }

  final int localeZero;

  final int _zeroOffset;
// !
  String _signPrefix(x) => x.isNegative ? negativePrefix : positivePrefix;

  String _signSuffix(x) => x.isNegative ? negativeSuffix : positiveSuffix;

  void turnOffGrouping() {
    _groupingSize = 0;
    _finalGroupingSize = 0;
  }

  @override
  String toString() => 'NumberFormat($_locale, $_pattern)';
}

final _ln10 = log(10);
