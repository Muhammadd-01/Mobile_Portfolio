import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: depend_on_referenced_packages
// import 'package:lucide_icons_flutter/lucide_icons_flutter.dart'; // Optional, if needed

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  final Map<String, List<Map<String, dynamic>>> skills = const {
    "Frontend": [
      {"name": "React.js", "level": "Expert", "icon": FontAwesomeIcons.react},
      {"name": "JavaScript", "level": "Expert", "icon": FontAwesomeIcons.js},
      {"name": "HTML/CSS", "level": "Expert", "icon": FontAwesomeIcons.html5},
      {"name": "Tailwind CSS", "level": "Expert", "icon": FontAwesomeIcons.css3Alt},
      {"name": "Bootstrap", "level": "Expert", "icon": FontAwesomeIcons.bootstrap},
    ],
    "Backend": [
      {"name": "C#", "level": "Advanced", "icon": FontAwesomeIcons.microsoft},
      {"name": "ASP.NET Core", "level": "Advanced", "icon": Icons.api}, // Replace with custom if needed
      {"name": "PHP", "level": "Intermediate", "icon": FontAwesomeIcons.php},
      {"name": "Laravel", "level": "Advanced", "icon": FontAwesomeIcons.laravel},
    ],
    "Database": [
      {"name": "SQL Server", "level": "Intermediate", "icon": Icons.storage},
      {"name": "MySQL", "level": "Intermediate", "icon": FontAwesomeIcons.database},
    ],
    "Tools": [
      {"name": "Git", "level": "Advanced", "icon": FontAwesomeIcons.gitAlt},
      {"name": "GitHub", "level": "Advanced", "icon": FontAwesomeIcons.github},
      {"name": "Vercel", "level": "Advanced", "icon": Icons.cloud_done},
      {"name": "Vite", "level": "Advanced", "icon": Icons.flash_on},
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: skills.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                entry.key,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 16.w,
                runSpacing: 16.h,
                alignment: WrapAlignment.center,
                children: entry.value.map((skill) {
                  return SkillCard(
                    name: skill["name"],
                    level: skill["level"],
                    category: entry.key,
                    icon: skill["icon"],
                  );
                }).toList(),
              ),
              SizedBox(height: 40.h),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SkillCard extends StatefulWidget {
  final String name;
  final String level;
  final String category;
  final IconData icon;

  const SkillCard({
    super.key,
    required this.name,
    required this.level,
    required this.category,
    required this.icon,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 150.w,
        height: 140.h,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: hovered ? Colors.blueGrey[800] : Colors.grey[900],
          border: Border.all(color: Colors.grey[700]!),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, size: 36.sp, color: Colors.white),
            SizedBox(height: 8.h),
            Text(
              widget.name,
              style: TextStyle(
                color: hovered ? Colors.blue[300] : Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "${widget.level} • ${widget.category}",
              style: TextStyle(
                color: hovered ? Colors.grey[300] : Colors.grey[500],
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
