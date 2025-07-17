import 'package:flutter/material.dart';
import '../widgets/projects_section.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: ProjectsSection(), // 👈 This displays the full section
      ),
    );
  }
}
