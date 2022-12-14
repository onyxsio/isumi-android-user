import 'dart:developer';

import 'package:onyxsio/onyxsio.dart';
// import 'package:onyxsio/app/authentication/sign_up/view/sign_up_form.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepository) : super(const SignUpState());

  final AuthRepository _authRepository;

  // void emailChanged(String value) {
  //   final email = Email.dirty(value);
  //   emit(
  //     state.copyWith(
  //       email: email,
  //       status: Formz.validate([
  //         email,
  //         state.password,
  //         state.phoneNumber,
  //         state.confirmedPassword,
  //       ]),
  //     ),
  //   );
  // }

  // void phoneChanged(String value) {
  //   final phone = PhoneNumber.dirty(value);

  //   emit(
  //     state.copyWith(
  //       phoneNumber: phone,
  //       status: Formz.validate([
  //         phone,
  //         state.email,
  //         state.password,
  //         state.confirmedPassword,
  //       ]),
  //     ),
  //   );
  // }

  // void passwordChanged(String value) {
  //   final password = Password.dirty(value);
  //   final confirmedPassword = ConfirmedPassword.dirty(
  //     password: password.value,
  //     value: state.confirmedPassword.value,
  //   );
  //   emit(
  //     state.copyWith(
  //       password: password,
  //       confirmedPassword: confirmedPassword,
  //       status: Formz.validate([
  //         state.email,
  //         state.phoneNumber,
  //         password,
  //         confirmedPassword,
  //       ]),
  //     ),
  //   );
  //   log(password.invalid.toString());
  // }

  // void confirmedPasswordChanged(String value) {
  //   final confirmedPassword = ConfirmedPassword.dirty(
  //     password: state.password.value,
  //     value: value,
  //   );
  //   emit(
  //     state.copyWith(
  //       confirmedPassword: confirmedPassword,
  //       status: Formz.validate([
  //         state.email,
  //         state.password,
  //         state.phoneNumber,
  //         confirmedPassword,
  //       ]),
  //     ),
  //   );
  //   log(confirmedPassword.invalid.toString());
  // }

  Future<void> signUpFormSubmitted() async {
    // if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on AppFirebaseFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
