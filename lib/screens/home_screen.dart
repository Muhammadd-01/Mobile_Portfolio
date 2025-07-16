import 'package:flutter/material.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HeroSection(),
            AboutSection(), // ✅ You already have this!
            // TODO: Header(), About(), Projects(), Footer() etc.
          ],
        ),
      ),
    );
  }
}
