import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hyve/core/theme/app_theme_light.dart";
import "package:hyve/features/auth/bloc/signup_bloc.dart";
import "../../home/view/home_page.dart";

class Signuppage extends StatelessWidget {
  const Signuppage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: const SignupView(),
    );
  }
}

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Signup successful! Please check your email.")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (state.status == SignupStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? "An error occurred")),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: BlocBuilder<SignupBloc, SignupState>(
            builder: (context, state) {
              if (!state.isFirstStep) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.read<SignupBloc>().add(SignupPreviousStepRequested()),
                );
              }
              return const BackButton();
            },
          ),
          title: const Text(
            "HYVE",
            style: TextStyle(
              color: Color.fromARGB(255, 87, 23, 30),
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: const Color.fromARGB(255, 87, 23, 30),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border, width: 2),
                ),
                child: BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: state.isFirstStep ? _buildStepOne(context, state) : _buildStepTwo(context, state),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepOne(BuildContext context, SignupState state) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      key: const ValueKey('step1'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          _buildStepHeader("Welcome to HYVE"),
          const SizedBox(height: 30),
          _buildLabel("COLLEGE EMAIL"),
          const SizedBox(height: 4),
          TextField(
            onChanged: (val) => context.read<SignupBloc>().add(SignupEmailChanged(val)),
            style: const TextStyle(color: Colors.black),
            decoration: _getInputDecoration(
              hint: "24bcs001",
              icon: Icons.alternate_email,
              suffix: _buildEmailSuffix(),
            ),
          ),
          const SizedBox(height: 20),
          _buildLabel("PASSWORD"),
          const SizedBox(height: 4),
          TextField(
            obscureText: !state.isPasswordVisible,
            onChanged: (val) => context.read<SignupBloc>().add(SignupPasswordChanged(val)),
            style: const TextStyle(color: Colors.black),
            decoration: _getInputDecoration(
              hint: "••••••••",
              icon: Icons.lock_outline,
              isPassword: true,
              isVisible: state.isPasswordVisible,
              onToggle: () => context.read<SignupBloc>().add(SignupTogglePasswordVisibility()),
            ),
          ),
          const SizedBox(height: 20),
          _buildLabel("CONFIRM PASSWORD"),
          const SizedBox(height: 4),
          TextField(
            obscureText: !state.isConfirmPasswordVisible,
            onChanged: (val) => context.read<SignupBloc>().add(SignupConfirmPasswordChanged(val)),
            style: const TextStyle(color: Colors.black),
            decoration: _getInputDecoration(
              hint: "••••••••",
              icon: Icons.lock_outline,
              isPassword: true,
              isVisible: state.isConfirmPasswordVisible,
              onToggle: () => context.read<SignupBloc>().add(SignupToggleConfirmPasswordVisibility()),
            ),
          ),
          const SizedBox(height: 30),
          _buildButton(
            text: "Next  ➯",
            onTap: () => context.read<SignupBloc>().add(SignupNextStepRequested()),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildStepTwo(BuildContext context, SignupState state) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      key: const ValueKey('step2'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
                    children: [
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            height: 100,
            width: 100,
            child: const Icon(Icons.person_outline, size: 50, color: AppColors.primary),
          ),
          const SizedBox(height: 40),
          _buildLabel("DISPLAY NAME"),
          const SizedBox(height: 4),
          TextField(
            onChanged: (val) => context.read<SignupBloc>().add(SignupDisplayNameChanged(val)),
            style: const TextStyle(color: Colors.black),
            decoration: _getInputDecoration(
              hint: "How should we call you?",
              icon: Icons.person_outline,
            ),
          ),
          const SizedBox(height: 40),
          _buildButton(
            text: state.status == SignupStatus.loading ? "Creating..." : "Signup  ➯",
            isLoading: state.status == SignupStatus.loading,
            onTap: () => context.read<SignupBloc>().add(SignupSubmitted()),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStepHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 87, 23, 30),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Enter your credentials to continue",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.borderMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "  $text",
        style: GoogleFonts.plusJakartaSans(
            fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }

  InputDecoration _getInputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onToggle,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.border),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: AppColors.border,
              ),
              onPressed: onToggle,
            )
          : suffix,
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary),
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

  Widget _buildButton({
    required String text,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
              : Text(
                  text,
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                ),
        ),
      ),
    );
  }
}
