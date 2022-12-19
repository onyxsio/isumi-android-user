import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

class SupportPage extends StatelessWidget {
  final String type;
  const SupportPage({Key? key, required this.type}) : super(key: key);
// TODO
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    switch (type) {
      case 'about':
        return Scaffold(
          appBar: appBar(text: 'About'),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    // FirestoreRepository().setupDeviceToken(user.id);
                  },
                  child: Text('setup Device Token to DB'),
                ),
                TextButton(
                  onPressed: () {
                    // FirestoreRepository().addCustomer(user.id);
                  },
                  child: Text('Add data to DB'),
                ),
                TextButton(
                  onPressed: () {
                    // FirestoreRepository().sendOrder(user.id);
                  },
                  child: Text('Send Order'),
                ),
              ],
            ),
          ),
        );
      case 'help':
        return Scaffold(
          appBar: appBar(text: 'Help and Support'),
        );
      default:
        return Scaffold(
          appBar: appBar(text: 'Terms & Conditions'),
        );
    }
  }
}
