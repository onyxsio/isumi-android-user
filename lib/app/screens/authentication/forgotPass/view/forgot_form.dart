import 'package:flutter/material.dart';
import 'package:isumi/app/screens/authentication/forgotPass/cubit/forgot_cubit.dart';
import 'package:onyxsio/onyxsio.dart';

TextEditingController email = TextEditingController();

class ForgotForm extends StatelessWidget {
  const ForgotForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotCubit, ForgotState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            Navigator.pop(context);
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    content:
                        Text(state.errorMessage ?? 'Password Reset Failure')),
              );
          }
        },
        child: Column(
          children: [
            const Spacer(flex: 1),
            Text('What’s your email? 📨', style: TxtStyle.h14B),
            const SizedBox(height: 16),
            Text(
              "We need your email to reset \nyour password.",
              textAlign: TextAlign.center,
              style: TxtStyle.b5,
            ),
            const Spacer(flex: 2),
            // _EmailInput(),
            TextBox(
              controller: email,
              type: TXT.email,
              hintText: 'email',
            ),
            const Spacer(flex: 3),
            _ResetButton()
          ],
        ));
  }
}

class _ResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotCubit, ForgotState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const HRDots()
            : MainButton(
                onTap: () {
                  context.read<ForgotCubit>().passwordReset();
                },
                text: 'Reset');
      },
    );
  }
}
