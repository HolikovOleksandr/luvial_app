import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
sealed class AuthEvent {}

final class AuthStarted extends AuthEvent {}

final class AuthLoggedIn extends AuthEvent {
  final User user;
  AuthLoggedIn(this.user);
}

final class AuthLoggedOut extends AuthEvent {}

final class AuthGoogleLoginRequested extends AuthEvent {}

final class AuthAppleLoginRequested extends AuthEvent {}

// final class AuthPhoneLoginRequested extends AuthEvent {
//   final String phoneNumber;
//   AuthPhoneLoginRequested(this.phoneNumber);
// }

// final class AuthPhoneCodeSubmitted extends AuthEvent {
//   final String verificationId;
//   final String smsCode;

//   AuthPhoneCodeSubmitted({required this.verificationId, required this.smsCode});
// }

// final class PhoneVerificationCompleted extends AuthEvent {
//   final User user;
//   PhoneVerificationCompleted(this.user);
// }

// final class PhoneVerificationFailed extends AuthEvent {
//   final String error;
//   PhoneVerificationFailed(this.error);
// }

// final class PhoneCodeSent extends AuthEvent {
//   final String verificationId;
//   PhoneCodeSent(this.verificationId);
// }
