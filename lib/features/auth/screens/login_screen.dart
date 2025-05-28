import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luvial_app/features/auth/bloc/auth_bloc.dart';
import 'package:luvial_app/features/auth/bloc/auth_event.dart';
import 'package:luvial_app/features/auth/bloc/auth_state.dart';
import 'package:luvial_app/features/auth/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String route = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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
        appBar: AppBar(
          title: const Text('Login'),
          leading: IconButton(
            onPressed: () {
              emailController.text = 'sanyagolikov97@email.com';
              passwordController.text = '123123132';
            },
            icon: Icon(Icons.text_format_sharp),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();

                  context.read<AuthBloc>().add(
                    AuthLoginRequested(email, password),
                  );
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () => context.go(RegisterScreen.route),
                child: Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _authFailure(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  _authSuccess(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Registration successful!')));
  }
}
