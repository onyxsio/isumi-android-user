import 'package:onyxsio/onyxsio.dart';
part 'forgot_state.dart';

class ForgotCubit extends Cubit<ForgotState> {
  ForgotCubit(this._auth) : super(const ForgotState());
  final AuthRepository _auth;
  // void emailChanged(String value) {
  //   final email = Email.dirty(value);
  //   emit(
  //     state.copyWith(
  //       email: email,
  //       status: Formz.validate([email, state.email]),
  //     ),
  //   );
  // }

  Future<void> passwordReset() async {
    try {
      // if (!state.status.isValidated) return;

      await _auth.forgotPassword(email: state.email.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on AppFirebaseFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
