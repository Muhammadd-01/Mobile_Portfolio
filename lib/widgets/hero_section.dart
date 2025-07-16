import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final List<String> titles = [
    "Full-Stack Developer",
    "UI/UX Enthusiast",
    "Tech Innovator"
  ];
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % titles.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Shader getGradientShader(Rect bounds) {
    return const LinearGradient(
      colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
    ).createShader(bounds);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key("hero"),
      padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 20.w),
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: 1.sh),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: getGradientShader,
            child: Text(
              "Hi, I'm Muhammad Affan",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            transitionBuilder: (child, animation) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: ShaderMask(
              key: ValueKey(_currentIndex),
              shaderCallback: getGradientShader,
              child: Text(
                titles[_currentIndex],
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          AnimatedOpacity(
            opacity: 1,
            duration: const Duration(seconds: 1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "I craft elegant, efficient, and user-centric digital solutions. With a passion for clean code and cutting-edge technologies, I transform complex problems into seamless experiences.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
          SizedBox(height: 25.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            alignment: WrapAlignment.center,
            children: [
              _buildButton("Let's Connect", () {
                _scrollToSection("contact");
              }, filled: true),
              _buildButton("Explore My Work", () {
                _scrollToSection("projects");
              }),
            ],
          ),
          SizedBox(height: 30.h),
          Wrap(
            spacing: 16.w,
            alignment: WrapAlignment.center,
            children: [
              _buildIcon(FontAwesomeIcons.github, 'https://github.com/Muhammadd-01'),
              _buildIcon(FontAwesomeIcons.linkedin, 'https://www.linkedin.com/in/muhammad-affan-8ab604280'),
              _buildIcon(FontAwesomeIcons.instagram, 'https://www.instagram.com'),
              _buildIcon(FontAwesomeIcons.facebook, 'https://www.facebook.com'),
              _buildIcon(FontAwesomeIcons.xTwitter, 'https://x.com/affann_23'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, {bool filled = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: filled ? Colors.black : Colors.white,
        backgroundColor: filled ? Colors.white : Colors.transparent,
        side: filled ? null : const BorderSide(color: Colors.white),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      ),
      child: Text(text, style: TextStyle(fontSize: 14.sp)),
    );
  }

  Widget _buildIcon(IconData icon, String url) {
    return InkWell(
      onTap: () {
        // Open URL using url_launcher in full app
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Icon(icon, color: Colors.white, size: 28.sp),
      ),
    );
  }

  void _scrollToSection(String id) {
    // Use ScrollController in parent widget with GlobalKey for scroll
    // Or use scrollable_positioned_list package
  }
}
