part of 'forgot_cubit.dart';

class ForgotState extends Equatable {
  const ForgotState({
    this.email = const Email.pure(),
    this.errorMessage,
    this.status = FormzStatus.pure,
  });
  final Email email;
  final String? errorMessage;
  final FormzStatus status;
  @override
  List<Object> get props => [email, status];

  ForgotState copyWith({
    Email? email,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return ForgotState(
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// class ForgotInitial extends ForgotState {}
