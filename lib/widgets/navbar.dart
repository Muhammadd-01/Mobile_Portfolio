import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Navbar extends StatefulWidget {
  final ScrollController scrollController;
  const Navbar({super.key, required this.scrollController});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool isScrolled = false;
  bool isOpen = false;

  final navItems = ["Home", "About", "Skills", "Projects", "Resume", "Contact"];

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (widget.scrollController.offset > 50 && !isScrolled) {
      setState(() => isScrolled = true);
    } else if (widget.scrollController.offset <= 50 && isScrolled) {
      setState(() => isScrolled = false);
    }
  }

  void scrollToSection(String id) {
    // Placeholder: implement scroll-to using GlobalKeys
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isScrolled)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.transparent),
            ),
          ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          height: 80.h,
          decoration: BoxDecoration(
            color: isScrolled
                ? Colors.black.withOpacity(0.6)
                : Colors.transparent,
            boxShadow: isScrolled
                ? [BoxShadow(color: Colors.black26, blurRadius: 12)]
                : [],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 768;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  _NeonText(
                    text: "Muhammad Affan",
                    fontSize: 26.sp,
                    onTap: () => scrollToSection("hero"),
                  ),

                  // Nav Items or Hamburger
                  if (isDesktop)
                    Row(
                      children: navItems.map((item) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: _NeonText(
                            text: item,
                            fontSize: 16.sp,
                            onTap: () => scrollToSection(item.toLowerCase()),
                          ),
                        );
                      }).toList(),
                    )
                  else
                    IconButton(
                      icon: Icon(
                        isOpen ? LucideIcons.x : LucideIcons.menu,
                        color: Colors.white,
                        size: 32.sp,
                      ),
                      onPressed: () => setState(() => isOpen = !isOpen),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _NeonText extends StatefulWidget {
  final String text;
  final double fontSize;
  final VoidCallback onTap;

  const _NeonText({
    required this.text,
    required this.fontSize,
    required this.onTap,
  });

  @override
  State<_NeonText> createState() => _NeonTextState();
}

class _NeonTextState extends State<_NeonText> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: hovering
                ? [
                    Shadow(color: Colors.cyanAccent, blurRadius: 10),
                    Shadow(color: Colors.cyan, blurRadius: 5),
                  ]
                : [],
          ),
        ),
      ),
    );
  }
}
