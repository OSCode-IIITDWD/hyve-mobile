import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hyve/core/theme/app_theme_light.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hyve/features/home/view/home_page.dart";
import "package:hyve/features/auth/bloc/login_bloc.dart";
import "signuppage.dart";

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Login Failed')),
          );
        } else if (state.status == LoginStatus.resetEmailSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage ?? 'Reset link sent!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: const Text(
            "HYVE",
            style: TextStyle(
              color: Color.fromARGB(255, 87, 23, 30),
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 87, 23, 30)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border, width: 2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 30),
                    _buildHeader(),
                    const SizedBox(height: 30),
                    _buildForm(context),
                    const SizedBox(height: 25),
                    _buildSubmitButton(),
                    const SizedBox(height: 20),
                    _buildFooter(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome back",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 87, 23, 30),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Enter your credentials to continue",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.borderMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "  COLLEGE EMAIL",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            onChanged: (email) =>
                context.read<LoginBloc>().add(LoginEmailChanged(email)),
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "24bcs001",
              hintStyle: const TextStyle(
                color: AppColors.border,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon:
                  const Icon(Icons.alternate_email, color: AppColors.border),
              suffixIcon: _buildEmailSuffix(),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 1.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildPasswordLabel(context),
          const SizedBox(height: 4),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) =>
                previous.isPasswordVisible != current.isPasswordVisible,
            builder: (context, state) {
              return TextField(
                obscureText: !state.isPasswordVisible,
                onChanged: (pass) =>
                    context.read<LoginBloc>().add(LoginPasswordChanged(pass)),
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "••••••••",
                  hintStyle: const TextStyle(
                    color: AppColors.border,
                    fontWeight: FontWeight.w900,
                  ),
                  prefixIcon:
                      const Icon(Icons.lock_outline, color: AppColors.border),
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.border,
                    ),
                    onPressed: () =>
                        context.read<LoginBloc>().add(LoginToggleVisibility()),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmailSuffix() {
    return UnconstrainedBox(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          "@iiitdwd.ac.in",
          style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildPasswordLabel(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "  PASSWORD",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () => context.read<LoginBloc>().add(LoginForgotPasswordRequested()),
          child: Text(
            "Forgot?   ",
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: state.status == LoginStatus.loading
              ? null
              : () => context.read<LoginBloc>().add(LoginSubmitted()),
          child: Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: state.status == LoginStatus.loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                  : Text(
                      "Next  ➯",
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have account?",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Signuppage()),
          ),
          child: Text(
            "SignUp",
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
