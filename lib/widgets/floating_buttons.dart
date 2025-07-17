import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // ✅ Add this

class FloatingButtons extends StatefulWidget {
  final ScrollController scrollController;

  const FloatingButtons({super.key, required this.scrollController});

  @override
  State<FloatingButtons> createState() => _FloatingButtonsState();
}

class _FloatingButtonsState extends State<FloatingButtons> {
  bool showScrollTop = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (widget.scrollController.offset > 300 && !showScrollTop) {
      setState(() => showScrollTop = true);
    } else if (widget.scrollController.offset <= 300 && showScrollTop) {
      setState(() => showScrollTop = false);
    }
  }

  void scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> openWhatsApp() async {
    final message = Uri.encodeComponent(
        "Hi Affan! I was checking out your portfolio and wanted to connect.");
    final url = Uri.parse("https://wa.me/923128538773?text=$message");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30.h,
      right: 20.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showScrollTop)
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Tooltip(
                message: 'Back to Top',
                child: GestureDetector(
                  onTap: scrollToTop,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_upward, color: Colors.white),
                  ),
                ),
              ),
            ),
          Tooltip(
            message: 'Chat with me!',
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  width: 60.r,
                  height: 60.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.4),
                  ),
                  child: const SizedBox(),
                ),
                GestureDetector(
                  onTap: openWhatsApp,
                  child: Container(
                    padding: EdgeInsets.all(14.r),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white), // ✅ If using `font_awesome_flutter`, replace with FaIcon
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
