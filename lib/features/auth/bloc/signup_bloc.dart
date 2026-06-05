import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SupabaseClient _supabase = Supabase.instance.client;

  SignupBloc() : super(SignupState()) {
    on<SignupEmailChanged>(_onEmailChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignupDisplayNameChanged>(_onDisplayNameChanged);
    on<SignupTogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<SignupToggleConfirmPasswordVisibility>(_onToggleConfirmPasswordVisibility);
    on<SignupNextStepRequested>(_onNextStepRequested);
    on<SignupPreviousStepRequested>(_onPreviousStepRequested);
    on<SignupSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(SignupEmailChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(email: event.email, status: SignupStatus.initial));
  }

  void _onPasswordChanged(SignupPasswordChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(password: event.password, status: SignupStatus.initial));
  }

  void _onConfirmPasswordChanged(SignupConfirmPasswordChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword, status: SignupStatus.initial));
  }

  void _onDisplayNameChanged(SignupDisplayNameChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(displayName: event.displayName, status: SignupStatus.initial));
  }

  void _onTogglePasswordVisibility(SignupTogglePasswordVisibility event, Emitter<SignupState> emit) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onToggleConfirmPasswordVisibility(SignupToggleConfirmPasswordVisibility event, Emitter<SignupState> emit) {
    emit(state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  void _onNextStepRequested(SignupNextStepRequested event, Emitter<SignupState> emit) {
    if (state.email.isEmpty || state.password.isEmpty || state.confirmPassword.isEmpty) {
      emit(state.copyWith(status: SignupStatus.failure, errorMessage: "Please fill all fields"));
      return;
    }
    if (state.password != state.confirmPassword) {
      emit(state.copyWith(status: SignupStatus.failure, errorMessage: "Passwords do not match"));
      return;
    }
    emit(state.copyWith(isFirstStep: false, status: SignupStatus.initial));
  }

  void _onPreviousStepRequested(SignupPreviousStepRequested event, Emitter<SignupState> emit) {
    emit(state.copyWith(isFirstStep: true, status: SignupStatus.initial));
  }

  Future<void> _onSubmitted(SignupSubmitted event, Emitter<SignupState> emit) async {
    if (state.displayName.isEmpty) {
      emit(state.copyWith(status: SignupStatus.failure, errorMessage: "Please enter a display name"));
      return;
    }

    emit(state.copyWith(status: SignupStatus.loading));

    try {
      final response = await _supabase.auth.signUp(
        email: '${state.email}@iiitdwd.ac.in',
        password: state.password,
        data: {'display_name': state.displayName},
      );
      
      if (response.user != null) {
        emit(state.copyWith(status: SignupStatus.success));
      } else {
        emit(state.copyWith(status: SignupStatus.failure, errorMessage: "Signup failed"));
      }
    } catch (e) {
      emit(state.copyWith(status: SignupStatus.failure, errorMessage: e.toString()));
    }
  }
}
