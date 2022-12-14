import 'package:flutter/material.dart';
import 'package:isumi/app/screens/authentication/sign_up/cubit/sign_up_cubit.dart';
import 'package:onyxsio/onyxsio.dart';

import 'sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  // static Route<void> route() {
  //   return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(context.read<AuthRepository>()),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
