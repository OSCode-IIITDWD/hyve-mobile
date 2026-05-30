import 'package:flutter/material.dart';
import 'package:hyve/features/professor_rating/widgets/professor_avatar.dart';
import 'package:hyve/features/professor_rating/widgets/professor_rating_theme.dart';

const _studentAvatar =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuCgboFrQThka--V2CotIuSlzqU2Zz8EfxDaIyG08-nAx6ym6RO1EITeGHMT7AjgW5o68jThK5DsJRUGA60hy2JwFwrKmh41KzTzEimIq8gtWajfX-Tx8hoUTnD16QtitQ04TwIJkIm7yzUn-pY028xSH7V6a79N0341hU-0sapB7g2jjn9Q0U_xy2Hc5snp1JpqXguMkGBiyxgoG1jy6RDkrlcotG7VrikfkpY4R985fIsJTQvhF-9pdjF5mJ44ObJ4AmVsFbXEUI4';

class ProfessorAppBar extends StatelessWidget {
  const ProfessorAppBar({
    super.key,
    this.centerLogo = false,
    this.title,
    this.onBack,
    this.onShare,
    this.onSearch,
  });

  final bool centerLogo;
  final String? title;
  final VoidCallback? onBack;
  final VoidCallback? onShare;
  final VoidCallback? onSearch;

  @override
  Widget build(BuildContext context) {
    final palette = context.professorPalette;

    if (onBack != null) {
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: palette.primary,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 64,
        titleSpacing: 0,
        leading: Center(
          child: _RoundIconButton(icon: Icons.arrow_back, onTap: onBack),
        ),
        title: title == null
            ? null
            : Text(
                title!,
                style: context.professorMobileTitle.copyWith(
                  color: palette.primary,
                ),
              ),
        actions: [
          if (onShare != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _RoundIconButton(
                icon: Icons.share_outlined,
                onTap: onShare,
              ),
            ),
        ],
      );
    }

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const ProfessorAvatar(imageUrl: _studentAvatar, size: 40),
                    if (!centerLogo) ...[
                      const SizedBox(width: 12),
                      Text(
                        'HYVE',
                        style: context.professorMobileTitle.copyWith(
                          color: palette.primary,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ],
                ),
                _RoundIconButton(icon: Icons.search, onTap: onSearch),
              ],
            ),
            if (centerLogo)
              Text(
                'HYVE',
                style: context.professorMobileTitle.copyWith(
                  color: palette.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.professorPalette;

    return IconButton(
      onPressed: onTap,
      style: IconButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: palette.primary,
        shape: const CircleBorder(),
      ),
      icon: Icon(icon),
      iconSize: 22,
    );
  }
}
