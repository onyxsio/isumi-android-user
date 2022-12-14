import 'package:firebase_core/firebase_core.dart';
import 'package:remote_data/remote_data.dart';
export 'auth_repository.dart';
export 'firestore_repository.dart';
export 'storage_repository.dart';
export 'message.dart';

class FirebaseService {
  static Future<void> init() async {
    // Initialize the Firebase app
    await Firebase.initializeApp();
    // Initialize the Notification Service
    await NotificationService.initializeFirebase();
    //
    await FirestoreRepository().setupDeviceToken();
    //
    // await FirestoreRepository().setupDashboard(emptyDash);
    // final authRepo = AuthRepository();
    // await authRepo.user.first;
  }
}
