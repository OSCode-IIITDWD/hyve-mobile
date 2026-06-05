part of 'signup_bloc.dart';

enum SignupStatus { initial, loading, success, failure }

class SignupState {
  final String email;
  final String password;
  final String confirmPassword;
  final String displayName;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isFirstStep;
  final SignupStatus status;
  final String? errorMessage;

  SignupState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.displayName = '',
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isFirstStep = true,
    this.status = SignupStatus.initial,
    this.errorMessage,
  });

  SignupState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? displayName,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isFirstStep,
    SignupStatus? status,
    String? errorMessage,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      displayName: displayName ?? this.displayName,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isFirstStep: isFirstStep ?? this.isFirstStep,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
