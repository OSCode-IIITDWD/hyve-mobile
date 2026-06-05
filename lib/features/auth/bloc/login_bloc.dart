import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SupabaseClient _supabase = Supabase.instance.client;

  LoginBloc() : super(LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginToggleVisibility>(_onToggleVisibility);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginForgotPasswordRequested>(_onForgotPasswordRequested);
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email, status: LoginStatus.initial));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password, status: LoginStatus.initial));
  }

  void _onToggleVisibility(LoginToggleVisibility event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> _onForgotPasswordRequested(
      LoginForgotPasswordRequested event, Emitter<LoginState> emit) async {
    if (state.email.isEmpty) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Please enter your email prefix (e.g. 24bcs001) first',
      ));
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final fullEmail = '${state.email.trim()}@iiitdwd.ac.in';
      await _supabase.auth.resetPasswordForEmail(fullEmail);
      emit(state.copyWith(
        status: LoginStatus.resetEmailSent,
        successMessage: 'Password reset link sent to $fullEmail',
      ));
    } on AuthException catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: e.message,
      ));
    } catch (e) {
      // Showing the actual error to help debugging
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Unexpected Error: ${e.toString()}',
      ));
    }
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Please fill in all fields',
      ));
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final response = await _supabase.auth.signInWithPassword(
        email: '${state.email.trim()}@iiitdwd.ac.in',
        password: state.password.trim(),
      );

      if (response.user != null) {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Login failed: Invalid credentials',
        ));
      }
    } on AuthException catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Unexpected Error: ${e.toString()}',
      ));
    }
  }
}
