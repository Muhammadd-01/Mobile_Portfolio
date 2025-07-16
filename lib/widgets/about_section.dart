import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key("about"),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 24.w),
      color: Colors.black, // Background same as your theme
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _AnimatedHoverText(
            delay: 0,
            child: Text(
              "Who Am I?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          _AnimatedSlideText(
            delay: 0.2,
            offsetX: -50,
            child: _buildParagraph(
              "I'm Muhammad Affan — a full-stack web developer, content creator, and lifelong learner. I specialize in building modern, real-world web applications using React, Laravel, Node.js, .NET, and TailwindCSS, with a strong focus on clean UI/UX, performance, and scalability.",
            ),
          ),
          _AnimatedSlideText(
            delay: 0.4,
            offsetX: 50,
            child: _buildParagraph(
              "Whether it’s frontend magic or backend logic, I’m passionate about turning ideas into fully functional digital products. I believe in building with purpose — using clean code, thoughtful design, and scalable architecture.",
            ),
          ),
          _AnimatedScaleText(
            delay: 0.6,
            child: _buildParagraph(
              "Outside tech, I study Islamic knowledge, psychology, and history — blending traditional wisdom with modern tools. I’m committed to growth, discipline, and creating solutions that matter. Let's build something impactful together.",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.grey[300],
          height: 1.5,
        ),
      ),
    );
  }
}
class _AnimatedHoverText extends StatefulWidget {
  final Widget child;
  final double delay;

  const _AnimatedHoverText({
    required this.child,
    required this.delay,
  });

  @override
  State<_AnimatedHoverText> createState() => _AnimatedHoverTextState();
}

class _AnimatedHoverTextState extends State<_AnimatedHoverText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _opacity = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _slide = Tween(begin: const Offset(0, -0.3), end: Offset.zero).animate(_controller);

    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: _hovering ? 1.1 : 1.0,
        child: FadeTransition(
          opacity: _opacity,
          child: SlideTransition(position: _slide, child: widget.child),
        ),
      ),
    );
  }
}

class _AnimatedSlideText extends StatefulWidget {
  final Widget child;
  final double offsetX;
  final double delay;

  const _AnimatedSlideText({
    required this.child,
    this.offsetX = 0,
    this.delay = 0,
  });

  @override
  State<_AnimatedSlideText> createState() => _AnimatedSlideTextState();
}

class _AnimatedSlideTextState extends State<_AnimatedSlideText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _opacity;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _slide = Tween<Offset>(begin: Offset(widget.offsetX / 100, 0), end: Offset.zero).animate(_controller);
    _opacity = Tween(begin: 0.0, end: 1.0).animate(_controller);

    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _opacity,
          child: Transform.translate(
            offset: Offset(_hovering ? (widget.offsetX > 0 ? -10 : 10) : 0, 0),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class _AnimatedScaleText extends StatefulWidget {
  final Widget child;
  final double delay;

const _AnimatedScaleText({
  required this.child,
  this.delay = 0,
});

  @override
  State<_AnimatedScaleText> createState() => _AnimatedScaleTextState();
}

class _AnimatedScaleTextState extends State<_AnimatedScaleText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _opacity = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _scale = Tween(begin: 0.8, end: 1.0).animate(_controller);

    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: _hovering ? 1.05 : 1.0,
        child: FadeTransition(
          opacity: _opacity,
          child: ScaleTransition(scale: _scale, child: widget.child),
        ),
      ),
    );
  }
}
