part of 'signup_bloc.dart';

sealed class SignupEvent {}

class SignupEmailChanged extends SignupEvent {
  final String email;
  SignupEmailChanged(this.email);
}

class SignupPasswordChanged extends SignupEvent {
  final String password;
  SignupPasswordChanged(this.password);
}

class SignupConfirmPasswordChanged extends SignupEvent {
  final String confirmPassword;
  SignupConfirmPasswordChanged(this.confirmPassword);
}

class SignupDisplayNameChanged extends SignupEvent {
  final String displayName;
  SignupDisplayNameChanged(this.displayName);
}

class SignupTogglePasswordVisibility extends SignupEvent {}

class SignupToggleConfirmPasswordVisibility extends SignupEvent {}

class SignupNextStepRequested extends SignupEvent {}

class SignupPreviousStepRequested extends SignupEvent {}

class SignupSubmitted extends SignupEvent {}
