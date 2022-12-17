import 'package:flutter/material.dart';
import 'package:isumi/app/screens/authentication/sign_up/cubit/sign_up_cubit.dart';
import 'package:onyxsio/onyxsio.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
// TextEditingController phone = TextEditingController();
TextEditingController rePassword = TextEditingController();

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5.w),
              Text('Getting started! ✌️', style: TxtStyle.h14B),
              SizedBox(height: 5.w),
              Text(
                "Look like you are new to us! Create an account for a complete experience.",
                textAlign: TextAlign.center,
                style: TxtStyle.b5,
              ),
              SizedBox(height: 10.w),
              // _EmailInput(),
              TextBox(hintText: 'Email', type: TXT.email, controller: email),

              // TextBox(
              //     hintText: 'Phone number', type: TXT.phone, controller: phone),

              TextBox(
                  hintText: 'Password',
                  type: TXT.password,
                  controller: password),

              // _ConfirmPasswordInput(),
              TextBox(
                  hintText: 'Re-Password',
                  type: TXT.password,
                  controller: rePassword),
              SizedBox(height: 10.w),
              _SignUpButton(),
              SizedBox(height: 5.w),
              _SignINButton()
              // Emaill
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      // buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const HRDots()
            : MainButton(
                onTap: () {
                  // TODO validation
                  context.read<SignUpCubit>().emailChanged(email.text);
                  // context.read<SignUpCubit>().phoneChanged(password.text);
                  context.read<SignUpCubit>().passwordChanged(password.text);
                  context
                      .read<SignUpCubit>()
                      .confirmedPasswordChanged(rePassword.text);

                  // if (state.status.isValidated) {
                  context.read<SignUpCubit>().signUpFormSubmitted();
                  // }
                },
                text: 'Get Started');
      },
    );
  }
}

class _SignINButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm'),
      onPressed: () => Navigator.pop(context),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(text: 'Already have an account? ', style: TxtStyle.b5),
          TextSpan(text: '  Login', style: TxtStyle.b5B),
        ]),
      ),
    );
  }
}
