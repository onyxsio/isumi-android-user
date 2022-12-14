enum ResultStatus {
  successful,
  invalid,
  undefined,
}

class Failure {
  // Use something like "int code;" if you want to translate error messages
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

//   static handleException(e) {
//     ResultStatus status;
//     switch (e.code) {
//       case "ERROR_INVALID_EMAIL":
//         status = ResultStatus.invalid;
//         break;
//       case "ERROR_WRONG_PASSWORD":
//         status = ResultStatus.invalid;
//         break;
//       case "ERROR_USER_NOT_FOUND":
//         status = ResultStatus.invalid;
//         break;
//       case "ERROR_USER_DISABLED":
//         status = ResultStatus.invalid;
//         break;
//       case "ERROR_TOO_MANY_REQUESTS":
//         status = ResultStatus.invalid;
//         break;
//       case "ERROR_OPERATION_NOT_ALLOWED":
//         status = ResultStatus.invalid;
//         break;
//       case "ERROR_EMAIL_ALREADY_IN_USE":
//         status = ResultStatus.invalid;
//         break;
//       default:
//         status = ResultStatus.undefined;
//     }
//     return status;
//   }
// }
//  throw Failure('No Internet connection 😑');
//  on SocketException {
//       throw Failure('No Internet connection 😑');
//     } on HttpException {
//       throw Failure("Couldn't find the post 😱");
//     } on FormatException {
//       throw Failure("Bad response format 👎");
//     }

class AppFirebaseFailure implements Exception {
  const AppFirebaseFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message

  factory AppFirebaseFailure.fromCode(String code) {
    switch (code) {
      case 'no-app':
        return const AppFirebaseFailure(
          'No Firebase App',
        );
      case 'invalid-email':
        return const AppFirebaseFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const AppFirebaseFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const AppFirebaseFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const AppFirebaseFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const AppFirebaseFailure(
          'Please enter a stronger password.',
        );
      case 'user-not-found':
        return const AppFirebaseFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const AppFirebaseFailure(
          'Incorrect password, please try again.',
        );
      case 'account-exists-with-different-credential':
        return const AppFirebaseFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const AppFirebaseFailure(
          'The credential received is malformed or has expired.',
        );
      case 'invalid-verification-code':
        return const AppFirebaseFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const AppFirebaseFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const AppFirebaseFailure();
    }
  }

  /// The associated error message.
  final String message;
}
// import 'package:firebase_core/firebase_core.dart';

// class AppFirebaseFailure implements FirebaseException {
//   const AppFirebaseFailure([
//     this.message = 'An unknown exception occurred.',
//   ]);

//   /// Create an authentication message

//   factory AppFirebaseFailure.fromCode(String code) {
//     switch (code) {
//       case 'no-app':
//         return const AppFirebaseFailure(
//           'No Firebase App',
//         );
//       case 'invalid-email':
//         return const AppFirebaseFailure(
//           'Email is not valid or badly formatted.',
//         );
//       case 'user-disabled':
//         return const AppFirebaseFailure(
//           'This user has been disabled. Please contact support for help.',
//         );
//       case 'email-already-in-use':
//         return const AppFirebaseFailure(
//           'An account already exists for that email.',
//         );
//       case 'operation-not-allowed':
//         return const AppFirebaseFailure(
//           'Operation is not allowed.  Please contact support.',
//         );
//       case 'weak-password':
//         return const AppFirebaseFailure(
//           'Please enter a stronger password.',
//         );
//       case 'user-not-found':
//         return const AppFirebaseFailure(
//           'Email is not found, please create an account.',
//         );
//       case 'wrong-password':
//         return const AppFirebaseFailure(
//           'Incorrect password, please try again.',
//         );
//       case 'account-exists-with-different-credential':
//         return const AppFirebaseFailure(
//           'Account exists with different credentials.',
//         );
//       case 'invalid-credential':
//         return const AppFirebaseFailure(
//           'The credential received is malformed or has expired.',
//         );
//       case 'invalid-verification-code':
//         return const AppFirebaseFailure(
//           'The credential verification code received is invalid.',
//         );
//       case 'invalid-verification-id':
//         return const AppFirebaseFailure(
//           'The credential verification ID received is invalid.',
//         );
//       default:
//         return const AppFirebaseFailure();
//     }
//   }

//   /// The associated error message.
//   final String message;
  
//   @override
//   // TODO: implement code
//   String get code => throw UnimplementedError();
  
//   @override
//   // TODO: implement plugin
//   String get plugin => throw UnimplementedError();
  
//   @override
//   // TODO: implement stackTrace
//   StackTrace? get stackTrace => throw UnimplementedError();
// }
