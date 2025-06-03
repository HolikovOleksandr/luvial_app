import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luvial_app/features/auth/bloc/auth_bloc.dart';
import 'package:luvial_app/features/auth/bloc/auth_event.dart';
import 'package:luvial_app/features/auth/bloc/auth_state.dart';
import 'package:luvial_app/features/auth/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String route = '/register';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          _authFailure(context, state.message);
        } else if (state is AuthAuthenticated) {
          _authSuccess(context);
          context.go('/home');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ось тут виводимо кнопки залежно від платформи
              _PlatformSignInButtons(),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => context.go(LoginScreen.route),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _authFailure(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _authSuccess(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Registration successful!')));
  }
}

class _PlatformSignInButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    List<Widget> buttons = [];

    if (Platform.isAndroid) {
      buttons.add(
        IconButton(
          onPressed: () => authBloc.add(AuthGoogleLoginRequested()),
          icon: const Icon(Icons.g_mobiledata, size: 64),
          tooltip: 'Sign in with Google',
        ),
      );
    }

    if (Platform.isIOS) {
      // Покажемо обидві кнопки на iOS — Google і Apple
      buttons.addAll([
        IconButton(
          onPressed: () => authBloc.add(AuthGoogleLoginRequested()),
          icon: const Icon(Icons.g_mobiledata, size: 64),
          tooltip: 'Sign in with Google',
        ),
        IconButton(
          onPressed: () => authBloc.add(AuthAppleLoginRequested()),
          icon: const Icon(Icons.apple, size: 64),
          tooltip: 'Sign in with Apple',
        ),
      ]);
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: buttons);
  }
}
