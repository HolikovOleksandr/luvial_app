import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luvial_app/features/auth/bloc/auth_bloc.dart';
import 'package:luvial_app/features/auth/bloc/auth_event.dart';
import 'package:luvial_app/features/auth/bloc/auth_state.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.read<AuthBloc>().add(AuthStarted());
    });
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
    listener: (context, state) => _authListener(context, state),
    child: SafeArea(
      child: const Scaffold(body: Center(child: Text('Splash Screen'))),
    ),
  );

  _authListener(BuildContext context, AuthState state) {
    if (state is AuthAuthenticated) {
      context.go('/home');
    } else if (state is AuthUnauthenticated) {
      context.go('/register');
    } else if (state is AuthFailure) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }
}
