import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthUnauthenticated extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);
}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
