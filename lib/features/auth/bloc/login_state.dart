part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure, resetEmailSent }

class LoginState {
  final String email;
  final String password;
  final LoginStatus status;
  final bool isPasswordVisible;
  final String? errorMessage;
  final String? successMessage;

  LoginState({
    this.email = '',
    this.password = '',
    this.status = LoginStatus.initial,
    this.isPasswordVisible = false,
    this.errorMessage,
    this.successMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    bool? isPasswordVisible,
    String? errorMessage,
    String? successMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}
