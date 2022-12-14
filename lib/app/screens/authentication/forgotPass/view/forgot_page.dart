import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';
import '../cubit/forgot_cubit.dart';
import 'forgot_form.dart';

class ForgotPassPage extends StatelessWidget {
  const ForgotPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: ''),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: BlocProvider(
          create: (_) => ForgotCubit(context.read<AuthRepository>()),
          child: const ForgotForm(),
        ),
      ),
    );
  }
}
