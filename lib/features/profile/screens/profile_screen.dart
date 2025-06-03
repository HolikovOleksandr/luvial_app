import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String route = '/profile';

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Center(child: Text('Profile Screen', style: Theme.of(context).textTheme.bodyLarge)),
    );
  }
}
