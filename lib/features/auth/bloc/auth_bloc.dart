import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luvial_app/features/auth/bloc/auth_event.dart';
import 'package:luvial_app/features/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<AuthStarted>((event, emit) => _onAuthStarted(emit));
    on<AuthRegisterRequested>(
      (event, emit) => _onRegisterRequested(event, emit),
    );
    on<AuthLoggedOut>((event, emit) => _onLoggedOut(emit));
    on<AuthLoginRequested>((event, emit) => _onLoginRequested(event, emit));
  }

  Future<void> _onAuthStarted(Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final user = _auth.currentUser;
    user != null ? emit(AuthAuthenticated(user)) : emit(AuthUnauthenticated());
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(AuthAuthenticated(credential.user!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(AuthAuthenticated(credential.user!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLoggedOut(Emitter<AuthState> emit) async {
    await _auth.signOut();
    emit(AuthUnauthenticated());
  }
}
