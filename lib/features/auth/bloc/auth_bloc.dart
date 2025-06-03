import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'auth_event.dart';
import 'auth_state.dart' hide AuthLoggedOut;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthGoogleLoginRequested>(_onGoogleSignInRequested);
    on<AuthAppleLoginRequested>(_onAppleLoginRequested);
    // on<AuthPhoneLoginRequested>(_onPhoneLoginRequested);
    // on<AuthPhoneCodeSubmitted>(_onPhoneCodeSubmitted);
    on<AuthLoggedOut>(_onLoggedOut);
  }

  Future<void> _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final user = _auth.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onGoogleSignInRequested(
    AuthGoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        emit(AuthUnauthenticated());
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      emit(AuthAuthenticated(userCredential.user!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAppleLoginRequested(
    AuthAppleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredential);
      final user = userCredential.user;

      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthFailure("Apple Sign-In failed: no user"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Future<void> _onPhoneLoginRequested(
  //   AuthPhoneLoginRequested event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   emit(AuthLoading());

  //   try {
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: event.phoneNumber,

  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         try {
  //           final userCredential = await _auth.signInWithCredential(credential);
  //           emit(AuthAuthenticated(userCredential.user!));
  //         } catch (e) {
  //           emit(AuthFailure(e.toString()));
  //         }
  //       },

  //       verificationFailed: (FirebaseAuthException e) {
  //         emit(AuthFailure(e.message ?? "Phone verification failed"));
  //       },

  //       codeSent: (String verificationId, int? resendToken) {
  //         emit(AuthCodeSent(verificationId));
  //       },

  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         // You can emit something here if you want to handle timeout
  //       },
  //     );
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }

  // Future<void> _onPhoneCodeSubmitted(AuthPhoneCodeSubmitted event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   try {
  //     final credential = PhoneAuthProvider.credential(
  //       verificationId: event.verificationId,
  //       smsCode: event.smsCode,
  //     );

  //     final userCredential = await _auth.signInWithCredential(credential);
  //     emit(AuthAuthenticated(userCredential.user!));
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }

  Future<void> _onLoggedOut(AuthLoggedOut event, Emitter<AuthState> emit) async {
    try {
      await _auth.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
