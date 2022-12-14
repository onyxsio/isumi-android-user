// import 'package:formz/formz.dart';
import 'formz.dart';

/// Validation errors for the [Password] [FormzInput].
enum PhoneNumberValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for an password input.
/// {@endtemplate}
class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  /// {@macro password}
  const PhoneNumber.pure() : super.pure('');

  /// {@macro password}
  const PhoneNumber.dirty([super.value = '']) : super.dirty();

  static final _phoneNumberRegExp =
      RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)');

  @override
  PhoneNumberValidationError? validator(String? value) {
    return _phoneNumberRegExp.hasMatch(value ?? '')
        ? null
        : PhoneNumberValidationError.invalid;
  }
}
