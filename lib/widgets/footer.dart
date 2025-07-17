import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<Footer> {
  final String aboutText =
      "Muhammad Affan — Full-stack web developer building modern apps with clean UI/UX, based in Karachi.";
  String typedText = "";
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _typeText();
  }

  void _typeText() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 50));
      if (_index < aboutText.length) {
        setState(() {
          typedText += aboutText[_index];
          _index++;
        });
        return true;
      }
      return false;
    });
  }

  void _scrollTo(String id) {
    // You’ll connect this with scroll logic via keys later
    debugPrint("Scroll to $id");
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Top Row
          LayoutBuilder(builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            return isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildContent(isMobile),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _buildContent(isMobile),
                  );
          }),

          const SizedBox(height: 30),
          const Divider(color: Colors.grey),
          const SizedBox(height: 10),
          const Text("© 2025 Affan. All rights reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  List<Widget> _buildContent(bool isMobile) {
    return [
      /// About
      Expanded(
        child: Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.start,
          children: [
            const Text("About Me",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    typedText,
                    style: const TextStyle(color: Colors.grey, height: 1.5),
                  ),
                ),
                const AnimatedTypingCursor(),
              ],
            ),
          ],
        ).animate().fadeIn(duration: 1000.ms).slideY(begin: 0.2),
      ),

      const SizedBox(width: 40, height: 30),

      /// Quick Links
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Quick Links",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 12),
            ...["hero", "about", "skills", "projects", "contact"].map(
              (section) => TextButton(
                onPressed: () => _scrollTo(section),
                child: Text(
                  section[0].toUpperCase() + section.substring(1),
                  style: const TextStyle(color: Colors.tealAccent),
                ),
              ),
            )
          ],
        ).animate().fadeIn(duration: 1200.ms).slideY(begin: 0.2),
      ),

      const SizedBox(width: 40, height: 30),

      /// Contact Info
      Expanded(
        child: Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            const Text("Contact",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 12),
            const Text("Karachi, Pakistan",
                style: TextStyle(color: Colors.grey)),
            InkWell(
              onTap: () => _launchURL("mailto:affan.work05@gmail.com"),
              child: const Text("affan.work05@gmail.com",
                  style: TextStyle(
                      color: Colors.tealAccent,
                      decoration: TextDecoration.underline)),
            ),
            InkWell(
              onTap: () => _launchURL("tel:+923128538773"),
              child: const Text("+92 312 8538773",
                  style: TextStyle(
                      color: Colors.tealAccent,
                      decoration: TextDecoration.underline)),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment:
                  isMobile ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                _buildIconButton(
                    FontAwesomeIcons.facebook,
                    "https://www.facebook.com/profile.php?id=61572493182768"),
                _buildIconButton(FontAwesomeIcons.github,
                    "https://github.com/Muhammadd-01"),
                _buildIconButton(FontAwesomeIcons.instagram,
                    "https://www.instagram.com/affann._12"),
                _buildIconButton(FontAwesomeIcons.linkedin,
                    "https://www.linkedin.com/in/muhammad-affan-8ab604280"),
                _buildIconButton(
                    FontAwesomeIcons.xTwitter, "https://x.com/affann_23"),
              ],
            )
          ],
        ).animate().fadeIn(duration: 1400.ms).slideY(begin: 0.2),
      ),
    ];
  }

  Widget _buildIconButton(IconData icon, String url) {
    return IconButton(
      icon: FaIcon(icon, size: 20),
      color: Colors.white,
      onPressed: () => _launchURL(url),
      hoverColor: Colors.transparent,
      splashRadius: 20,
    );
  }
}

class AnimatedTypingCursor extends StatelessWidget {
  const AnimatedTypingCursor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 24,
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: Colors.tealAccent,
        borderRadius: BorderRadius.circular(2),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true)).fadeIn(duration: 500.ms);
  }
}
