import 'package:flutter/material.dart';
import 'package:isumi/changes/strings.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class SupportPage extends StatelessWidget {
  final String type;
  const SupportPage({Key? key, required this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final user = context.select((AppBloc bloc) => bloc.state.user);
    switch (type) {
      case 'about':
        return Scaffold(
          appBar: appBar(text: 'About'),
          body: _about(),
        );
      case 'help':
        return Scaffold(
          appBar: appBar(text: 'Help and Support'),
          body: _help(),
        );
      default:
        return Scaffold(
          appBar: appBar(text: 'Terms & Conditions'),
        );
    }
  }

  Widget _about() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(AppImage.logo, width: 20.w, height: 20.w),
        TextButton(
            onPressed: () => openURL(AppLinks.onyxsio),
            child: const Text('Developed by Onyxsio (Pvt) Ltd')),
        const Text('App version 1.2'),
        // Row(
        //   children: [Text('1.2')],
        // )
      ],
    ));
  }

  Widget _help() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text('Contact Seller'),
        // const Text('Contact Seller'),
      ],
    ));
  }
}
