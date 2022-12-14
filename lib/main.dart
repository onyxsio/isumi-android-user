import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Onyxsio.init();
  // runApp(const MyApp());
  final authRepo = AuthRepository();
  await authRepo.user.first;
  runApp(AppProviders(authRepo: authRepo));
}
