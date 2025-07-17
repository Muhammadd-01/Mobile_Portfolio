import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../models/project_data.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String filter = 'All';

  List<String> get categories => ['All', ...{
    ...projects.map((p) => p.category),
  }];

  @override
  Widget build(BuildContext context) {
    final filtered = filter == 'All' ? projects : projects.where((p) => p.category == filter).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Column(
        children: [
          Text('My Projects', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 20),
          Wrap(
            spacing: 12,
            children: categories.map((category) {
              final selected = filter == category;
              return ChoiceChip(
                label: Text(category),
                selected: selected,
                onSelected: (_) => setState(() => filter = category),
                selectedColor: Colors.white,
                labelStyle: TextStyle(color: selected ? Colors.black : Colors.white),
                backgroundColor: Colors.grey[800],
              );
            }).toList(),
          ),
          SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: filtered.map((project) => ProjectCard(project: project)).toList(),
          ),
        ],
      ),
    );
  }
}
