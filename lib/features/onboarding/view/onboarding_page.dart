import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyve/core/theme/app_theme.dart';
import "package:hyve/features/auth/view/login.dart";
import 'package:hyve/features/onboarding/bloc/onboarding_bloc.dart';

// ─── Data Model ──────────────────────────────────────────────────────────────

class OnBoardingModel {
  final String title;
  final String description;
  final String image;

  const OnBoardingModel({
    required this.title,
    required this.description,
    required this.image,
  });
}

const List<OnBoardingModel> onBoardinglist = [
  OnBoardingModel(
    title: 'Your Campus, Unified',
    description:
        'One app to navigate logistics, access services, and thrive — friction-free.',
    image: 'assets/onboarding/onboarding1.png',
  ),
  OnBoardingModel(
    title: 'Stay in the Loop',
    description:
        'News, announcements, events, and a vibrant community for all your academic and non-academic needs.',
    image: 'assets/onboarding/onBoarding2.png',
  ),
  OnBoardingModel(
    title: 'Organize Your Day',
    description:
        'Timetables, planners, and schedules — all in one place, always at your fingertips.',
    image: 'assets/onboarding/onBoarding3.png',
  ),
];

// ─── Screen (provides its own BLoC) ──────────────────────────────────────────

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(totalPages: onBoardinglist.length),
      child: const _OnBoardingView(),
    );
  }
}

// ─── View (consumes BLoC) ─────────────────────────────────────────────────────

class _OnBoardingView extends StatefulWidget {
  const _OnBoardingView();

  @override
  State<_OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<_OnBoardingView> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _syncPageController(int index) {
    if (_pageController.hasClients && _pageController.page?.round() != index) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = AppTheme.light.colorScheme;

    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingInProgress) {
          _syncPageController(state.currentIndex);
        } else if (state is OnboardingComplete) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoginPage()),
          );
        }
      },
      builder: (context, state) {
        if (state is! OnboardingInProgress) return const SizedBox.shrink();

        return Scaffold(
          backgroundColor: colorScheme.surface,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                height: 10,
                width: 10,
                margin: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: onBoardinglist.length,
                  onPageChanged: (index) => context
                      .read<OnboardingBloc>()
                      .add(OnboardingPageChanged(index)),
                  itemBuilder: (context, index) =>
                      OnBoardingCard(onBoardingModel: onBoardinglist[index]),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: DotsIndicator(
                  dotsCount: onBoardinglist.length,
                  position: state.currentIndex.toDouble(),
                  decorator: DotsDecorator(
                    color: colorScheme.primary.withValues(alpha: 0.4),
                    size: const Size.square(8.0),
                    activeSize: const Size(20.0, 8.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    activeColor: colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 23, bottom: 36),
                child: PrimaryButton(
                  elevation: 0,
                  onTap: () => context
                      .read<OnboardingBloc>()
                      .add(OnboardingNextTapped()),
                  text: state.isLastPage ? 'Get Started' : 'Next',
                  borderRadius: 20,
                  height: 46,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Reusable Widgets ─────────────────────────────────────────────────────────

class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? elevation;
  final double? fontSize;
  final IconData? iconData;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.elevation = 5,
    this.borderRadius,
    this.fontSize,
    this.iconData,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _animationDuration)
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = AppTheme.light.colorScheme;

    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) => _controller.reverse());
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          elevation: widget.elevation ?? 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          child: Container(
            height: widget.height ?? 55,
            width: widget.width ?? double.maxFinite,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            ),
            child: Text(
              widget.text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: widget.fontSize ?? 14,
                fontWeight: FontWeight.w500,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OnBoardingCard extends StatelessWidget {
  final OnBoardingModel onBoardingModel;

  const OnBoardingCard({super.key, required this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: SizedBox()),
        Image.asset(
          onBoardingModel.image,
          height: 300,
          width: double.maxFinite,
          fit: BoxFit.fitWidth,
        ),
        const Expanded(child: SizedBox()),
        OnboardingTextCard(onBoardingModel: onBoardingModel),
      ],
    );
  }
}

class OnboardingTextCard extends StatelessWidget {
  final OnBoardingModel onBoardingModel;

  const OnboardingTextCard({required this.onBoardingModel, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = AppTheme.light.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        children: [
          Text(
            onBoardingModel.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            onBoardingModel.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
