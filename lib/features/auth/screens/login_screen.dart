import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luvial_app/features/auth/bloc/auth_bloc.dart';
import 'package:luvial_app/features/auth/bloc/auth_state.dart';
import 'package:luvial_app/features/auth/screens/register_screen.dart';
import 'package:luvial_app/features/auth/widgets/platform_signin_button.dart';
import 'package:luvial_app/features/profile/screens/profile_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String route = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          _authFailure(context, state.message);
        } else if (state is AuthAuthenticated) {
          _authSuccess(context);
          context.go(ProfileScreen.route);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Login')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const PlatformSignInButtons(),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () => context.go(RegisterScreen.route),
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _authFailure(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _authSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login successful!')));
  }
}
