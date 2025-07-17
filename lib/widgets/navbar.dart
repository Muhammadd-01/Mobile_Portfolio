import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Navbar extends StatefulWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  const Navbar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

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
    final key = widget.sectionKeys[id.toLowerCase()];
    if (key != null) {
      final ctx = key.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Stack(
        children: [
          if (isScrolled)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                height: 80.h,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            height: 80.h,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > 768;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _NeonText(
                      text: "Muhammad Affan",
                      fontSize: 26.sp,
                      onTap: () => scrollToSection("home"),
                    ),
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
      ),
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
                    const Shadow(color: Colors.cyanAccent, blurRadius: 10),
                    const Shadow(color: Colors.cyan, blurRadius: 5),
                  ]
                : [],
          ),
        ),
      ),
    );
  }
}
