import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Widgets
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/floating_buttons.dart'; // ✅ New combined button widget

// Sections
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/resume_section.dart';
import '../widgets/contact_section.dart';

// Global Keys
import '../models/section_keys.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80.h), // Offset for navbar
                // Sections
                Container(key: sectionKeys['hero'], child: const HeroSection()),
                Container(
                  key: sectionKeys['about'],
                  child: const AboutSection(),
                ),
                Container(
                  key: sectionKeys['skills'],
                  child: const SkillsSection(),
                ),
                Container(
                  key: sectionKeys['projects'],
                  child: const ProjectsSection(),
                ),
                Container(
                  key: sectionKeys['resume'],
                  child: const ResumeSection(),
                ),
                Container(
                  key: sectionKeys['contact'],
                  child: const ContactSection(),
                ),

                const Footer(),
              ],
            ),
          ),

          // Floating Navbar
          Navbar(scrollController: _scrollController, sectionKeys: sectionKeys),

          // ✅ Combined floating buttons (WhatsApp + Scroll-To-Top)
          FloatingButtons(scrollController: _scrollController),
        ],
      ),
    );
  }
}
