import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';

import '../../models/education_model.dart';
import '../../models/language_model.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  void _downloadResume() async {
    const url = 'https://yourdomain.com/AffanResume.pdf'; // Replace with actual PDF URL
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Animate(
            effects: [
              FadeEffect(duration: 500.ms),
              SlideEffect(begin: const Offset(0, 0.3)),
            ],
            child: Text(
              "Resume",
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
            ),
          ),

          const SizedBox(height: 40),

          /// EDUCATION
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Education",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...educationList.mapIndexed((index, edu) {
            return Animate(
              effects: [
                FadeEffect(duration: 400.ms),
                SlideEffect(begin: const Offset(0, 0.2)),
              ],
              delay: (index * 200).ms,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E2E2E), Color(0xFF1C1C1C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          edu.degree,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.cyanAccent,
                          ),
                        ),
                        Text(
                          edu.year,
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      edu.school,
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 40),

          /// LANGUAGES
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Languages",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...languageList.mapIndexed((index, lang) {
            return Animate(
              effects: [
                FadeEffect(duration: 400.ms),
                SlideEffect(begin: const Offset(0, 0.2)),
              ],
              delay: (index * 200).ms,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E2E2E), Color(0xFF1C1C1C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lang.name,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.cyanAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      lang.level,
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 40),

          /// DOWNLOAD BUTTON
          Animate(
            effects: [
              ScaleEffect(duration: 300.ms),
              FadeEffect(duration: 300.ms),
            ],
            child: ElevatedButton(
              onPressed: _downloadResume,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 12,
              ),
              child: const Text(
                "Download Full Resume",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
