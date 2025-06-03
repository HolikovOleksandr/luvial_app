import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luvial_app/features/auth/bloc/auth_event.dart' as auth_event;
import 'package:luvial_app/features/auth/bloc/auth_state.dart';
import 'package:luvial_app/features/auth/screens/login_screen.dart';

import '../../auth/bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String route = '/profile';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go(LoginScreen.route);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                  child: user?.photoURL != null
                      ? const Icon(Icons.account_circle_outlined, size: 50)
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  user?.displayName ?? 'No Name',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    context.read<AuthBloc>().add(auth_event.AuthLoggedOut());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
