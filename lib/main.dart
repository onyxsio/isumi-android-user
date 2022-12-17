import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Onyxsio.init();
  final authRepo = AuthRepository();
  await authRepo.user.first;
  runApp(AppProviders(authRepo: authRepo));
}


// clothstore.jp@gmail.com
// JpC987456
// JpC987456@J

// project-761954711929