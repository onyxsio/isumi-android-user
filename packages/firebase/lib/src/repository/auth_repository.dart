import 'dart:async';
// import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cache/cache.dart';
import 'package:remote_data/remote_data.dart';
// import 'package:remote_data/src/error/failure.dart';
// import 'package:remote_data/src/model/models.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

class AuthRepository {
  AuthRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final GoogleSignIn _googleSignIn;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  static const userCacheKey = '__user_cache_key__';

  /// Stream of User which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits User.empty if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to User.empty if there is no cached user.
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  /// Creates a new user with the provided email] and password].
  Future<void> signUp({required String email, required String password}) async {
    try {
      var newuser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirestoreRepository.createAccount(newuser.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AppFirebaseFailure.fromCode(e.code);
    } catch (_) {
      throw const AppFirebaseFailure();
    }
  }

  /// Creates a new user with the provided email] and password].
  Future<void> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AppFirebaseFailure.fromCode(e.code);
    } catch (_) {
      throw const AppFirebaseFailure();
    }
  }

  /// Signs in with the provided email and password.
  ///
  /// Throws a LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AppFirebaseFailure.fromCode(e.code);
    } catch (e) {
      throw const AppFirebaseFailure();
    }
  }

  /// Starts the Sign In with Google Flow.

  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;

      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var user = await _firebaseAuth.signInWithCredential(credential);
      // googleUser.
      await FirestoreRepository.createAccount(user.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AppFirebaseFailure.fromCode(e.code);
    } catch (e) {
      throw const AppFirebaseFailure();
    }
  }

  /// Signs out the current user which will emit
  /// User.empty] from the user] Stream.
  ///
  /// Throws a LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {
      throw const AppFirebaseFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
        id: uid,
        email: email,
        name: displayName,
        photo: photoURL,
        phone: phoneNumber);
  }
}
