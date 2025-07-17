import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  void _launch(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.transparent, width: 4),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              project.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                Text(project.category, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 8),
                Text(project.description, style: TextStyle(color: Colors.grey[300], fontSize: 14)),
                SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _launch(project.github),
                      icon: Icon(Icons.code, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () => _launch(project.live),
                      icon: Icon(Icons.open_in_new, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
