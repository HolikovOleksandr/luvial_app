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

final class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;
  AuthRegisterRequested(this.email, this.password);
}

final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  AuthLoginRequested(this.email, this.password);
}
