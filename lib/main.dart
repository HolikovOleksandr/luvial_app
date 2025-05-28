import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luvial_app/features/auth/bloc/auth_bloc.dart';
import 'package:luvial_app/firebase_options.dart';
import 'package:luvial_app/luvial_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider<AuthBloc>(create: (_) => AuthBloc())],
      child: const LuvialApp(),
    ),
  );
}
